//
//  ContentView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            //Screen background color
            Color.miniIce
                .ignoresSafeArea()
            
            //W
            VStack {
                Text("Welcome! 👋")
                    .font(.poppins(.regular, size: 20))
                
            }
            .padding()
        }
        .onAppear(){
            for family: String in UIFont.familyNames
            {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family)
                {
                    print("== \(names)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
