//
//  Extensions.swift
//  DevProfile
//
//  Created by eren on 10.03.2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
