//
//  ShazamKitHelper.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import AVFAudio
import Foundation
import ShazamKit
import MusicKit

class ShazamKitHelper: NSObject, SHSessionDelegate {
    private var musicKitSongResponse: MySongResponse?
    private let audioEngine = AVAudioEngine()
    private let mixerNode = AVAudioMixerNode()
    private var isAuthorizedForMusicKit: Bool = false
    
    // The closure that will be called in the UI
    private var matchHandler: ((BinarySong?, Error?) -> Void)?
    
    // The session for the active ShazamKit match request.
    private var session: SHSession? = nil
    
    init(handler: ((BinarySong?, Error?) -> Void)?) {
        self.matchHandler = handler
    }
    
    func match(catalog: SHCustomCatalog? = nil) throws {
        // Instantiate SHSession if one doesn't already exist
        if (session == nil) {
            // Use custom catalog if defined
            if let catalog = catalog {
                session = SHSession(catalog: catalog)
            } else {
                session = SHSession()
            }
            session?.delegate = self
        }
        
        // Start listening to the audio to find a match.
        try startListening()
    }
    
    func addAudio(buffer: AVAudioPCMBuffer, audioTime: AVAudioTime) {
        // Add the audio to the current match request.
        session?.matchStreamingBuffer(buffer, at: audioTime)
    }
    
    
    //Call only on initliazation!
    func configureAudioEngine() {
        // Get the native audio format of the engine's input bus.
        let inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        
        // Set an output format compatible with ShazamKit.
        let outputFormat = AVAudioFormat(standardFormatWithSampleRate: 48000, channels: 1)
        
        // Create a mixer node to convert the input.
        audioEngine.attach(mixerNode)
        
        // Attach the mixer to the microphone input and the output of the audio engine.
        audioEngine.connect(audioEngine.inputNode, to: mixerNode, format: inputFormat)
        audioEngine.connect(mixerNode, to: audioEngine.outputNode, format: outputFormat)
        
        // Install a tap on the mixer node to capture the microphone audio.
        mixerNode.installTap(onBus: 0,
                             bufferSize: 8192,
                             format: outputFormat) { buffer, audioTime in
            // Add captured audio to the buffer used for making a match.
            self.addAudio(buffer: buffer, audioTime: audioTime)
        }
    }
    
    func startListening() throws {
        // Throw an error if the audio engine is already running.
        guard !audioEngine.isRunning else { return }
        let audioSession = AVAudioSession.sharedInstance()
        
        // Ask the user for permission to use the mic if required then start the engine.
        try audioSession.setCategory(.playAndRecord)
        audioSession.requestRecordPermission { [weak self] success in
            guard success, let self = self else { return }
            try? self.audioEngine.start()
        }
    }
    
    func stopListening() {
        // Check if the audio engine is already recording.
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
    
    func requestMusicAuthorization() {
        Task {
            let authorizationStatus = await MusicAuthorization.request()
            if authorizationStatus == .authorized {
                isAuthorizedForMusicKit = true
            } else {
                // User denied permission.
            }
        }
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if let handler = self.matchHandler {
                let shazamKitData: SHMediaItem = match.mediaItems.first!
                var musicKitData: Song? = nil
                
                
                // Get Song data from MusicKit
                if self.isAuthorizedForMusicKit {
                    Task {
                        self.musicKitSongResponse = await shazamKitData.getMusicKitSong()
                        musicKitData = (self.musicKitSongResponse?.data.first)!
                        
                        //Create a BinarySong using shazam and apple music track data
                        let songData = BinarySong(shazamKitData: shazamKitData, musicKitData: musicKitData)
                        
                        handler(songData, nil)
                        self.stopListening()
                    }
                }
            }
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if let handler = self.matchHandler {
                handler(nil, error)
                self.stopListening()
            }
        }
    }
    
    public func addToShazamLibrary(songs: [SHMediaItem]) {
      SHMediaLibrary.default.add(songs) { error in
        if let error = error {
            print(error.localizedDescription.debugDescription)
        } else {
          print("DEBUG: Added to Shazam Library")
        }
      }
    }
}

struct MySongResponse: Decodable {
    let data: [Song?]
}

extension SHMediaItem {
    func getMusicKitSong() async -> MySongResponse {
        do {
            let countryCode = try await MusicDataRequest.currentCountryCode
            guard let songID = self.appleMusicID else {
                print("DEBUG: Apple Music API Request Failed (\"Get a Catalog Song\")")
                return MySongResponse(data: [nil])
            }
            let url = URL(string: "https://api.music.apple.com/v1/catalog/\(countryCode)/songs/\(songID)")!

            let dataRequest = MusicDataRequest(urlRequest: URLRequest(url: url))
            let dataResponse = try await dataRequest.response()

            let decoder = JSONDecoder()
            let songResponse = try decoder.decode(MySongResponse.self, from: dataResponse.data)
            return songResponse
        } catch {
            print("DEBUG: Apple Music API Request Failed (\"Get a Catalog Song\")")
            return MySongResponse(data: [nil])
        }
    }
}
