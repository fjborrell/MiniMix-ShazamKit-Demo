//
//  ListenView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit
import MusicKit

struct ListenView: View {
    // Data Variables
    @State var matchedSong: BinarySong?
    @Binding var shazamHelper: ShazamKitHelper?
    
    // UI State Variables
    @Binding var isShowingSong: Bool
    @State var isListening: Bool = false
    @State var isSoundWavesAnimated: Bool = false
    @State var showingFailedMatchAlert: Bool = false
    
    var body: some View {
        ZStack {
            // MARK: SCREEN BACKGROUND GRADIENT
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: LISTENING STATUS
                VStack {
                    if isListening {
                        Label("Listening...", systemImage: "waveform.and.mic")
                            .labelStyle(.trailingIcon)
                            .font(.poppins(.medium, size: 20))
                            .padding()
                    } else {
                        Label("Tap to Identify", systemImage: "mic.fill")
                            .labelStyle(.trailingIcon)
                            .foregroundColor(.white)
                            .font(.poppins(.semibold, size: 20))
                            .padding()
                    }
                    
                    // MARK: SONG MATCH (LISTEN) BUTTON
                    Button(action: {
                        // Try to match song via ShazamKit
                        do {
                            isListening = true
                            isSoundWavesAnimated = true
                            try shazamHelper?.match()
                        }
                        // Catch error in song match startup
                        catch {
                            print("DEBUG: Failed to start the matching process")
                            isListening = false
                            isSoundWavesAnimated = false
                            shazamHelper?.stopListening()
                        }
                    }, label: {
                        Image("miniMicrophone")
                    })
                    .buttonStyle(.neobrutalismCircle)
                    .padding()
                }
                
                // MARK: ANIMATED SOUND WAVE (LISTENING INDICATOR)
                SoundWaveView(isSoundWavesAnimated: $isSoundWavesAnimated)
                    .padding(50)
                
                // MARK: DESCRIPTION
                Text("Powered by ShazamKit")
                    .font(.poppins(.italic, size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding(12)
            }
        }
        // A song's data sheet is presented only once a song has been matched and it's appropriate BinarySong data type has been created
        .sheet(isPresented: $isShowingSong) {
            SongSizingView(song: $matchedSong, isShowingSong: $isShowingSong, shazamHelper: $shazamHelper)
        }
        
        // Configures a ShazamKitHelper if one doesn't already exist
        .onAppear {
            if shazamHelper == nil {
                shazamHelper = ShazamKitHelper(handler: finishedSongMatch)
                
                // Requests user access to Apple Music Catalog
                shazamHelper?.requestMusicAuthorization()
                
                //The built-in microphones on devices running iOS 14 and earlier are already compatible with ShazamKit
                if #available(iOS 15, *) {
                    shazamHelper?.configureAudioEngine()
                }
            }
        }
        // Alert to inform user of song match time-out or failure
        .alert("Match Failed", isPresented: $showingFailedMatchAlert, actions: {
            Button("Continue", role: .cancel, action: {
                showingFailedMatchAlert = false
            })
        }, message: {
            Text("Unfortunately a song could not be identified. Please try again.")
        })
    }
    
    // Helper function that handles UI events and data updates following a song match request
    func finishedSongMatch(item: BinarySong?, error: Error?) {
        if item != nil {
            //Handles successful match
            print("DEBUG: Successful song match")
            matchedSong = item
            User.globalUser.addMediaToShazamHistory(item: item)
            isListening = false
            isSoundWavesAnimated = false
            isShowingSong = true
        } else {
            //Handles error in match
            print("DEBUG: Failed to find a song match -> \(error.debugDescription)")
            isListening = false
            isSoundWavesAnimated = false
            showingFailedMatchAlert = true
        }
    }
}

/*
 struct ListenView_Previews: PreviewProvider {
     static var previews: some View {
         ListenView(shazamHelper: .constant(ShazamKitHelper(handler: finishedSongMatch(self.init()))), isShowingSong: .constant(false), isAuthorizedForMusicKit: .constant(true))
     }
     
     func finishedSongMatch(item: SHMatchedMediaItem?, error: Error?) {}
 }
 */

