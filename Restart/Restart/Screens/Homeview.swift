//
//  Homeview.swift
//  Restart
//
//  Created by test on 26/11/2021.
//

import SwiftUI

struct Homeview: View {
    @AppStorage("onboarding") var isOnBoardingViewActive = false
    @State private var isAnimated = false
    var body: some View {
        
        VStack(spacing: 20) {
            Spacer()
            ZStack {
                CirclesBackground(color: .gray, opacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimated ? -35 : 35)
                    .animation(
                        Animation
                            .easeOut(duration: 4)
                            .repeatForever(),
                        value: isAnimated)
            }
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button {
                withAnimation {
                    isOnBoardingViewActive = true
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimated = true
            }
        }
    }
}

struct Homeview_Previews: PreviewProvider {
    static var previews: some View {
        Homeview()
    }
}
