//
//  String+Localized.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 08.01.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
