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
    @State var shazamHelper: ShazamKitHelper?
    @State var matchedSong: SHMediaItem?
    @State var isShowingSong: Bool = false
    @State var isListening: Bool = false
    @State var isAuthorizedForMusicKit: Bool = false
    
    
    var body: some View {
        ZStack {
            //Screen background gradient
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    if isListening {
                        Label("Listening...", systemImage: "waveform.and.mic")
                            .labelStyle(.trailingIcon)
                            .font(.poppins(.medium, size: 20))
                            .padding()
                    } else {
                        Label("Tap to Identify", systemImage: "mic.fill")
                            .labelStyle(.trailingIcon)
                            .font(.poppins(.medium, size: 20))
                            .padding()
                    }
                    
                    
                    Button(action: {
                        do {
                            isListening = true
                            try shazamHelper?.match()
                        }
                        catch {
                            print("DEBUG: Failed to start the matching process")
                            isListening = false
                            shazamHelper?.stopListening()
                        }
                    }, label: {
                        Image("miniMicrophone")
                    })
                    .buttonStyle(.neobrutalismCircle)
                    .padding()
                }
                
                Text("Use music recognition to seamlessly connect to Shazam’s catalog of music")
                    .font(.poppins(.regular, size: 14))
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding(12)
            }
        }
        .sheet(isPresented: $isShowingSong) {
            SongSizingView(song: $matchedSong, isShowingSong: $isShowingSong, shazamHelper: $shazamHelper, isAuthorizedForMusicKit: $isAuthorizedForMusicKit)
        }
        .onAppear {
            if shazamHelper == nil {
                shazamHelper = ShazamKitHelper(handler: finishedSongMatch)
                
                //The built-in microphones on devices running iOS 14 and earlier are already compatible with ShazamKit
                if #available(iOS 15, *) {
                    shazamHelper?.configureAudioEngine()
                }
            }
            Task {
                requestMusicAuthorization()
            }
            
        }
        .onDisappear {
            //Privacy double-down in case listening didn't stop after song was identified
            shazamHelper?.stopListening()
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
    
    func finishedSongMatch(item: SHMatchedMediaItem?, error: Error?) {
        if error != nil {
            //handle error match
            print("DEBUG: Failed to find a song match -> \(error.debugDescription)")
        } else {
            //handle success match
            print("DEBUG: Successful song match")
            shazamHelper?.stopListening()
            matchedSong = item
            User.globalUser.addMediaToShazamHistory(item: item)
            isShowingSong = true
        }
    }
}

struct ListenView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView()
    }
}
