//
//  WelcomeView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/2/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: SCREEN BACKGROUND GRADIENT
                Color.pastelBackground
                    .ignoresSafeArea()
                
                // MARK: WELCOME PAGE ASSETS
                VStack {
                    Text("Welcome! 👋")
                        .font(.poppins(.semibold, size: 28))
                    
                    Image("musicSession")
                        .padding(.bottom, 60)
                        .padding(.top, 20)
                    
                    Image("miniMixLogo")
                    
                    Text("Use music recognition to seamlessly connect to Shazam’s catalog of music")
                        .font(.poppins(.regular, size: 14))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .padding(12)
                    
                    // Navigates to RootView (TabView -> ListenView)
                    NavigationLink(destination: RootView(), label: {
                        Label("Get Started", systemImage: "arrow.right.circle")
                            .labelStyle(.trailingIcon)
                    })
                    .buttonStyle(.neobrutalismRect)
                    .font(.poppins(.semibold, size: 20))
                }
                .padding()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
