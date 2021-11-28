//
//  ContentView.swift
//  Restart
//
//  Created by test on 26/11/2021.
//

import SwiftUI

struct ContentView: View {
    //Fonctionne comme UserDefault
    @AppStorage("onboarding") var isOnBoardingViewActive = true
    
    var body: some View {
        ZStack {
            if isOnBoardingViewActive {
                OnBoardingView()
            } else {
                Homeview()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
