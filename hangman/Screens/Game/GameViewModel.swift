//
//  GameViewModel.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation

final class GameViewModel {

    private(set) var isHeadVisible = Bindable<Bool>(false)
    private(set) var isNeckVisible = Bindable<Bool>(false)
    private(set) var isCorpusVisible = Bindable<Bool>(false)
    private(set) var isLeftArmVisible = Bindable<Bool>(false)
    private(set) var isRightArmVisible = Bindable<Bool>(false)
    private(set) var isLeftHandVisible = Bindable<Bool>(false)
    private(set) var isRightHandVisible = Bindable<Bool>(false)
    private(set) var isLeftLegVisible = Bindable<Bool>(false)
    private(set) var isRightLegVisible = Bindable<Bool>(false)
    private(set) var isLeftFootVisible = Bindable<Bool>(false)
    private(set) var isRightFootVisible = Bindable<Bool>(false)

    private(set) var maskedWord = Bindable<String>("")
    private(set) var guessedLetters = Set<Character>()


    private let model: GameModel

    init(model: GameModel) {
        self.model = model

        self.maskedWord = Bindable<String>(updatingMasking())
    }

    public func guess(letter letterToBeGuessed: Character) {

        // make sure that the letter hasn't been already guessed
        guard !guessedLetters.contains(letterToBeGuessed) else {
            assert(false, "Letter to be guessed has already been guessed!")
            return
        }

        guessedLetters.insert(letterToBeGuessed)

        updateMasking()

    }

    private func updateMasking() {

        var updatedWord = model.word

        // for each uniqe letter in String
        Set(model.word).forEach({ letter in
            // if the guessedLetters doesn't contain a particular letter
            if !guessedLetters.contains(letter) && !letter.isWhitespace {
                // replace all it occurances with underscore
                updatedWord = updatedWord.replacingOccurrences(of: String(letter), with: "_")
            }

        })

        maskedWord.value = updatedWord

    }

    private func updatingMasking() -> String {

        var updatedWord = model.word

        // for each uniqe letter in String
        Set(model.word).forEach({ letter in
            // if the guessedLetters doesn't contain a particular letter
            if !guessedLetters.contains(letter) && !letter.isWhitespace {
                // replace all it occurances with underscore
                updatedWord = updatedWord.replacingOccurrences(of: String(letter), with: "_")
            }

        })

        return updatedWord

    }

    
}
