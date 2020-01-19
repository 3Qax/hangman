//
//  SummaryModel.swift
//  hangman
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import Foundation

struct SummaryModel {
    let didWin: Bool
    let timeNeeded: TimeInterval
    let guessedLetters: Set<Character>
    let wordToGuess: String
}
