//
//  ContentView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/2/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            //Screen background gradient
            LinearGradient.pastelBackground
                .ignoresSafeArea()
            
            VStack {
                Text("Welcome! 👋")
                    .font(.poppins(.semibold, size: 28))
                
                Image("musicAfro")
                    .padding(.bottom, 60)
                    .padding(.top, 20)
                
                Image("miniMixLogo")
                
                Text("Use music recognition to seamlessly connect to Shazam’s catalog of music")
                    .font(.poppins(.regular, size: 14))
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding(12)
                
                Button(action: {
                    
                }) {
                    Text("Get Started")
                }
                .buttonStyle(.neobrutalismRect)
                
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
