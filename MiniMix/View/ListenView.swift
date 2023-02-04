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
    @State var displayingSong: Bool = false
    
    var body: some View {
        if displayingSong {
            SongView(song: $matchedSong)
        }
        
        ZStack {
            //Screen background gradient
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    Label("Tap to Identify", systemImage: "mic.fill")
                        .labelStyle(.trailingIcon)
                        .font(.poppins(.medium, size: 20))
                        .padding()
                    
                    Button(action: {
                        
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
            .padding()
        }
        .onAppear {
            if shazamHelper == nil {
                shazamHelper = ShazamKitHelper(handler: finishedSongMatch)
            }
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
            displayingSong = true
        }
    }
}

struct ListenView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView()
    }
}
