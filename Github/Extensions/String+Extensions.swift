//
//  String+Extensions.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

extension String {
    var deleteHTMLTags: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
