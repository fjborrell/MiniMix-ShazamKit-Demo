//
//  ListenView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/4/23.
//

import SwiftUI
import ShazamKit

struct ListenView: View {
    @State var shazamHelper: ShazamKitHelper?
    @State var matchedSong: SHMediaItem?
    @State var isShowingSong: Bool = false
    @State var isListening: Bool = false
    
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
                            try shazamHelper?.match()
                        }
                        catch {
                            print("DEBUG: Match failed")
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
            SongSizingView(song: $matchedSong)
            //SongView(song: $matchedSong, isShowingSong: $isShowingSong)
        }
        .onAppear {
            if shazamHelper == nil {
                shazamHelper = ShazamKitHelper(handler: finishedSongMatch)
                
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
    
    func finishedSongMatch(item: SHMatchedMediaItem?, error: Error?) {
        if error != nil {
            //handle error match
            print("DEBUG: \(error.debugDescription)")
        } else {
            //handle success match
            print("DEBUG: Successful song match")
            matchedSong = item
            isShowingSong = true
        }
    }
}

struct ListenView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView()
    }
}
