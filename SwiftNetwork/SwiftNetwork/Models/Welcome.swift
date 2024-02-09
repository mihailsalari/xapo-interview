//
//  Welcome.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public struct Welcome {
    public let title: String
    public let goButtonTitle: String
    public let descriptionShort: String
    public let descriptionLong: String
    public let openAppButtonTitle: String
    
    public let privacyPolicy: String
    public let termsOfUse: String
    public let andText: String
    
    public let termsURLString: String
    public let policyURLString: String
    public let xapoURLString: String

    public init(title: String = "Welcome to iOS Test",
                goButtonTitle: String = "Go to Xapo",
                descriptionShort: String = "iOS Test for Xapo bank",
                descriptionLong: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                openAppButtonTitle: String = "Enter the app",
                privacyPolicy: String = "Privacy policy",
                termsOfUse: String = "Terms of use",
                andText: String = "and",
                termsURLString: String = "https://legal.xapobank.com/privacy/privacy-policy",
                policyURLString: String = "https://legal.xapobank.com/tos/bank",
                xapoURLString: String = "https://www.xapobank.com/") {
        self.title = title
        self.goButtonTitle = goButtonTitle
        self.descriptionShort = descriptionShort
        self.descriptionLong = descriptionLong
        self.openAppButtonTitle = openAppButtonTitle
        self.privacyPolicy = privacyPolicy
        self.termsOfUse = termsOfUse
        self.andText = andText
        self.termsURLString = termsURLString
        self.policyURLString = policyURLString
        self.xapoURLString = xapoURLString
    }
}
