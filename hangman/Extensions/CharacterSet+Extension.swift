//
//  CharacterSet+Extension.swift
//  hangman
//
//  Created by Jakub Towarek on 23/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import Foundation

extension CharacterSet {

    static var environmentalVariableNameAllowed: CharacterSet {
        var environmentalVariableNameAllowed = CharacterSet()
        environmentalVariableNameAllowed.formUnion(CharacterSet.letters)
        environmentalVariableNameAllowed.formUnion(CharacterSet.decimalDigits)
        environmentalVariableNameAllowed.insert("_")
        return environmentalVariableNameAllowed
    }
}
