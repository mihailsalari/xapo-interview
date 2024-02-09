//
//  SplashView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import UIKit

struct SplashView: View {
    @State private var animatedGradient = true
    @State private var logoOpacity: Double = 1
    
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        ZStack {
            backgroundGradient
            logoImage
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                logoOpacity = 0 
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                coordinator.showWelcomeScreen()
            }
        }
    }
    
    private var logoImage: some View {
        Image(uiImage: UIImage(named: "xapo-logo")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90, height: 90)
            .foregroundColor(.orange)
            .opacity(logoOpacity)
            .accessibility(identifier: .splashScreenImage)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [Color(uiColor: .splashBackground), .brown, Color(uiColor: .splashBackground)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .hueRotation(.degrees(animatedGradient ? 45 : 0))
        .ignoresSafeArea()
        .accessibility(identifier: .splashScreenGradient)
        .onAppear {
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                animatedGradient.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                coordinator.showWelcomeScreen()
            }
        }
    }
}
