//
//  OnBoardingView.swift
//  Restart
//
//  Created by test on 26/11/2021.
//

import SwiftUI

struct OnBoardingView: View {
    //MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnBoardingViewActive = true
    @State private var buttonOffset: CGFloat = 0
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var isAnimated: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1
    @State private var textTitle: String = "Share."
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea()
            //Header
            VStack(spacing: 20) {
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                        Is not how much we give but
                        how much love we put into giving.
                        """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimated ? 1: 0)
                .offset(y: isAnimated ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimated)
                
                
                //Center
                ZStack {
                    CirclesBackground(color: .white, opacity: 0.2)
                    // -1 pour que les cercles aillent en sens inverse de l'image
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 0.2), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimated ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimated)
                    // la multiplication accèlere le mouvement de la translation
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.2)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        imageOffset = .zero
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                        )
                        .overlay(Image(systemName: "arrow.left.and.right.circle")
                                    .font(.system(size: 44, weight: .ultraLight))
                                    .foregroundColor(.white)
                                    .offset(y: 10)
                                    .opacity(isAnimated ? 1 : 0)
                                    .animation(.easeOut(duration: 1).delay(2), value: isAnimated)
                                    .opacity(indicatorOpacity)
                                 , alignment: .bottom)
                }
                
                //Slider background
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 10)
                    
                    //Draggable button
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                        //on fait grandir la frame du background rouge en meme temps que la translation
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        
                        Spacer()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Si on bouge le bouton vers la droite  et qu'on arrive au bout de la capsule
                                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                    //le bouton se déplace sur la largeur
                                    buttonOffset = gesture.translation.width
                                }
                            }
                            .onEnded { _ in
                                //arrivée à la moitié de la capsule on passe à Homeview
                                withAnimation(.easeOut(duration: 0.5)) {
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnBoardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                }
                            }
                    )
                    Spacer()
                    
                }
                .frame(width:buttonWidth ,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimated ? 1 :0)
                .offset(y: isAnimated ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimated)
            }
        }
        .onAppear {
            isAnimated = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

