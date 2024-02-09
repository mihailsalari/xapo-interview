//
//  WelcomeScreenView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import Foundation

struct WelcomeScreenView: View {
    private struct Constants {
        static let bottomStackHeight: CGFloat = 120
        static let logoImageName = "xapo-logo"
        static let logoFrameSize: CGFloat = 90
        static let animationDuration: Double = 0.5
        static let initialSpeed: Double = 5
        static let rotationDivisor: Double = 3
        static let titleFontSize: CGFloat = 40
        static let subtitleFontSize: CGFloat = 15
    }
    
    @State private var animatedGradient = true
    @State private var showElements = [false, false, false, false, false, false]
    @State private var rotationAngle: Double = 0
    
    @State private var logoOpacity: Double = 1
    @State private var logoPosition: CGSize = .zero
        
    @StateObject var viewModel: WelcomeScreenViewModel
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        ZStack {
            backgroundGradient
            topRightButton
            mainContent
            bottomContent
        }
        .onAppear {
            rotateImage(times: 3, initialSpeed: 5)
            animateElementsInSequence()
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [Color(uiColor: .splashBackground), .brown, Color(uiColor: .splashBackground)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .hueRotation(.degrees(animatedGradient ? 45 : 0))
        .ignoresSafeArea()
        .onAppear { withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
            animatedGradient.toggle()
        }}
    }
    
    private var topRightButton: some View {
        Button(action: viewModel.openTermsOfUse) {
            Text(viewModel.welcome.goButtonTitle.localized)
                .padding(.top, 12)
                .padding(.trailing, 12)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .semibold))
        }
        .offset(x: showElements[0] ? 0 : -UIScreen.main.bounds.width, y: 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    
    private var mainContent: some View {
        VStack(spacing: 20) {
            logoImage
            textContent
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, Constants.bottomStackHeight)
    }
    
    private var logoImage: some View {
        Image(uiImage: UIImage(named: Constants.logoImageName)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.logoFrameSize, height: Constants.logoFrameSize)
            .foregroundColor(.orange)
            .scaleEffect(showElements[1] ? 1 : 0)
            .rotationEffect(.degrees(rotationAngle))
            .onTapGesture {
                rotateImage(times: 3, initialSpeed: Constants.initialSpeed)
            }
            .accessibility(identifier: .welcomeScreenLogo)
    }
    
    private var textContent: some View {
        VStack(spacing: 20) {
            Text(viewModel.welcome.title.localized)
                .modifier(DefaultTextViewModifier(fontSize: Constants.titleFontSize, fontWeight: .bold))
                .opacity(showElements[2] ? 1 : 0)
                .offset(y: showElements[2] ? 0 : -30)
                .accessibility(identifier: .welcomeScreenTitle)
            
            VStack(spacing: 10) {
                Text(viewModel.welcome.descriptionShort.localized)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(showElements[3] ? 1 : 0)
                    .offset(y: showElements[3] ? 0 : -30)
                
                Text(viewModel.welcome.descriptionLong.localized)
                    .withDefaultTextViewModifier()
                    .opacity(showElements[3] ? 1 : 0)
                    .offset(y: showElements[3] ? 0 : -30)
            }
        }
    }
    
    private var bottomContent: some View {
        VStack {
            Spacer()
            
            Button(action: viewModel.enterApp) {
                Text(viewModel.welcome.openAppButtonTitle.localized)
                    .font(.headline)
                    .foregroundColor(Color(uiColor: .splashText))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.accent))
                    .cornerRadius(40)
            }
            .accessibility(identifier: .welcomeScreenGoToButton)
            .padding()
            .offset(y: showElements[4] ? 0 : UIScreen.main.bounds.height)
            
            privacyAndTermsLinks
        }
        .padding()
    }
    
    private var privacyAndTermsLinks: some View {
        HStack(spacing: 4) {
            if let privacyURL = viewModel.privacyPolicyURL, let termsURL = viewModel.termsOfUseURL {
                Link(destination: privacyURL) {
                    Text(viewModel.welcome.privacyPolicy.localized).modifier(DefaultPrivacyTextViewModifier())
                }
                
                Text(viewModel.welcome.andText.localized).foregroundColor(Color(.white))
                
                Link(destination: termsURL) {
                    Text(viewModel.welcome.termsOfUse.localized).modifier(DefaultPrivacyTextViewModifier())
                }
            }
        }
        .font(.footnote)
        .opacity(showElements[5] ? 1 : 0)
        .offset(y: showElements[5] ? 0 : 30)
    }
    
    private func animateElementsInSequence() {
        let delays = [1.5, 0.0, 0.5, 0.75, 1.0, 1.2]
        for (index, delay) in delays.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.easeOut(duration: Constants.animationDuration)) {
                    showElements[index] = true
                }
            }
        }
    }
    
    private func rotateImage(times: Int, initialSpeed: Double) {
        let totalRotation = 360.0 * Double(times)
        withAnimation(Animation.linear(duration: 1 / initialSpeed)) {
            rotationAngle += totalRotation / Constants.rotationDivisor
        }
        
        let secondDuration = 1 / (initialSpeed / 5 * 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 / initialSpeed) {
            withAnimation(Animation.linear(duration: secondDuration)) {
                rotationAngle += totalRotation / Constants.rotationDivisor
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 / initialSpeed + secondDuration) {
            withAnimation(Animation.linear(duration: 1 / (initialSpeed / 5))) {
                rotationAngle += totalRotation / Constants.rotationDivisor
            }
        }
    }
}
