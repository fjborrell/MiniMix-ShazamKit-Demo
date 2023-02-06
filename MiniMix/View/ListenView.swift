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
    @Binding var shazamHelper: ShazamKitHelper?
    @State var matchedSong: BinarySong?
    @Binding var isShowingSong: Bool
    @State var isListening: Bool = false
    @State private var musicKitSongResponse: MySongResponse?
    @State var musicKitSong: Song?
    
    
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
        .onDisappear {
            //Privacy double-down in case listening didn't stop after song was identified
            shazamHelper?.stopListening()
        }
    }
    
    func finishedSongMatch(item: BinarySong?, error: Error?) {
        if error != nil {
            //handle error match
            print("DEBUG: Failed to find a song match -> \(error.debugDescription)")
        } else {
            //handle success match
            print("DEBUG: Successful song match")
            matchedSong = item
            User.globalUser.addMediaToShazamHistory(item: item)
            isListening = false
            isShowingSong = true
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

