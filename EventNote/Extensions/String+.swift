//
//  String+.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 06.01.2023.
//

import Foundation

extension String {
    
    enum RegexType {
        case none
        case mobileNumberWithItalianCode         // Example: "+39 3401234567"
        case email                               // Example: "foo@example.com"
        case minLetters(_ letters: Int)          // Example: "Al"
        case minDigit(_ digits: Int)             // Example: "0612345"
        case onlyLetters                         // Example: "ABDEFGHILM"
        case onlyNumbers                         // Example: "132543136"
        case noSpecialChars                      // Example: "Malago'": OK - "Malagò": KO
        
        fileprivate var pattern: String {
            switch self {
                
            case .none:
                return ""
            case .mobileNumberWithItalianCode:
                return #"^(\+39 )\d{9,}$"#
            case .email:
                return #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#
            case .minLetters(let letters):
                return #"^\D{"# + "\(letters)" + #",}$"#
            case .minDigit(let digits):
                return #"^(\d{"# + "\(digits)" + #",}){1}$"#
            case .onlyLetters:
                return #"^[A-Za-z]+$"#
            case .onlyNumbers:
                return #"^[0-9]"#
            case .noSpecialChars:
                return #"^[A-Za-z0-9\s+\\\-\/?:().,']+$"#
            }
        }
    }
    
    // MARK: - Validation
        /// - Perform a regex validation of the string
        /// - Parameter regexType: enum type of the regex to use
        /// - Returns: the result of the test
    
    func isValidWith(regexType: RegexType) -> Bool {
        
        switch regexType {
        case .none:
            return true
        default:
            break
        }
        
        let pattern = regexType.pattern
        guard let gRegex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: self.utf16.count)
        
        if gRegex.firstMatch(in: self, options: [], range: range) != nil {
            return true
        }
        
        
        return false
    }
    
}
