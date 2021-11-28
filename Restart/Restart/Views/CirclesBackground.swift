//
//  ImageCharacterWithBackgroundCircle.swift
//  Restart
//
//  Created by test on 28/11/2021.
//

import SwiftUI


struct CirclesBackground: View {
    
    var color: Color
    var opacity: Double
 
    @State private var isAnimated: Bool = false
    var body: some View {
        ZStack {
            ZStack{
                Circle()
                    .stroke(color.opacity(opacity), lineWidth: 40)
                    .frame(width: 260, height: 260, alignment: .center)
                Circle()
                    .stroke(color.opacity(opacity), lineWidth: 80)
                    .frame(width: 260, height: 260, alignment: .center)
            }
            .blur(radius: isAnimated ? 0 : 10)
            .opacity(isAnimated ? 1 : 0)
            .scaleEffect(isAnimated ? 1 : 0.5)
            .animation(.easeOut(duration: 1), value: isAnimated)
            .onAppear {
                isAnimated = true
            }
        }
    }
}

struct ImageCharacterWithBackgroundCircle_Previews: PreviewProvider {
    static var previews: some View {
        CirclesBackground(color: .white, opacity: 0.2)
            .preferredColorScheme(.dark)
    }
}
