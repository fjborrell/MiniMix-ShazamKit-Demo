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
    
    @State var matchedSong: BinarySong?
    @State var isListening: Bool = false
    @State var showingFailedMatchAlert: Bool = false
    @State var isSoundWavesAnimated: Bool = false
    
    @Binding var shazamHelper: ShazamKitHelper?
    @Binding var isShowingSong: Bool
    
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
                            .foregroundColor(.white)
                            .font(.poppins(.semibold, size: 20))
                            .padding()
                    }
                    
                    
                    Button(action: {
                        do {
                            isListening = true
                            isSoundWavesAnimated = true
                            try shazamHelper?.match()
                        }
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
                
                SoundWaveView(isSoundWavesAnimated: $isSoundWavesAnimated)
                    .padding(50)
                
                Text("Powered by ShazamKit")
                    .font(.poppins(.italic, size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding(12)
                
                
                
            }
        }
        .sheet(isPresented: $isShowingSong) {
            SongSizingView(song: $matchedSong, isShowingSong: $isShowingSong, shazamHelper: $shazamHelper)
        }
        .onAppear {
            if shazamHelper == nil {
                shazamHelper = ShazamKitHelper(handler: finishedSongMatch)
                shazamHelper?.requestMusicAuthorization()
                
                //The built-in microphones on devices running iOS 14 and earlier are already compatible with ShazamKit
                if #available(iOS 15, *) {
                    shazamHelper?.configureAudioEngine()
                }
            }
        }
        .alert("Match Failed", isPresented: $showingFailedMatchAlert, actions: {
            Button("Continue", role: .cancel, action: {
                showingFailedMatchAlert = false
            })
        }, message: {
            Text("Unfortunately a song could not be identified. Please try again.")
        })
    }
    
    func finishedSongMatch(item: BinarySong?, error: Error?) {
        if item != nil {
            //handle success match
            print("DEBUG: Successful song match")
            matchedSong = item
            User.globalUser.addMediaToShazamHistory(item: item)
            isListening = false
            isSoundWavesAnimated = false
            isShowingSong = true
        } else {
            //handle error match
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

