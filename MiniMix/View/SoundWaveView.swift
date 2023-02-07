//
//  SoundWaveView.swift
//  MiniMix
//
//  Created by Fernando Borrell on 2/6/23.
//

import SwiftUI

struct SoundWaveView: View {
    @Binding var isSoundWavesAnimated: Bool
    let targetHeight: CGFloat = 70
    
    @ViewBuilder
    func waveSlice(start: Double, end: Double, stiffness: Double) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 10, height: isSoundWavesAnimated ? end : start)
            .foregroundColor(.miniBlue)
            .animation(.interpolatingSpring(stiffness: stiffness, damping: isSoundWavesAnimated ? 0 : .infinity), value: isSoundWavesAnimated)
    }
    
    var body: some View {
        HStack{
            waveSlice(start: 40, end: 70, stiffness: 10)
            waveSlice(start: 80, end: 110, stiffness: 15)
            waveSlice(start: 60, end: 90, stiffness: 6)
            waveSlice(start: 130, end: 100, stiffness: 11)
            waveSlice(start: 80, end: 110, stiffness: 19)
            waveSlice(start: 50, end: 80, stiffness: 8)
        }
        .frame(height: targetHeight)
    }
}

//struct SoundWaveView_Previews: PreviewProvider {
//    static var previews: some View {
//        SoundWaveView(isSoundWavesAnimated: .constant(false))
//    }
//}
