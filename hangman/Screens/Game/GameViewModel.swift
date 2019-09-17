//
//  GameViewModel.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func didGuessIncorrectly()
    func didGuessCorrectly()
    func gameOver()
}

final class GameViewModel {

    public weak var delegate: GameViewModelDelegate?

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

    private var numberOfIncorrectGuesses = 0 { didSet { calculateFolkVisibility() }}
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

        if model.word.contains(letterToBeGuessed) {
            delegate?.didGuessCorrectly()
        } else {
            numberOfIncorrectGuesses += 1
            delegate?.didGuessIncorrectly()
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

    private func calculateFolkVisibility() {
        switch numberOfIncorrectGuesses {
        case 11:
            isRightFootVisible.value = true
            fallthrough
        case 10:
            isLeftFootVisible.value = true
            fallthrough
        case 9:
            isRightLegVisible.value = true
            fallthrough
        case 8:
            isLeftLegVisible.value = true
            fallthrough
        case 7:
            isRightHandVisible.value = true
            fallthrough
        case 6:
            isLeftHandVisible.value = true
            fallthrough
        case 5:
            isRightArmVisible.value = true
            fallthrough
        case 4:
            isLeftArmVisible.value = true
            fallthrough
        case 3:
            isCorpusVisible.value = true
            fallthrough
        case 2:
            isNeckVisible.value = true
            fallthrough
        case 1:
            isHeadVisible.value = true
        default:
            assert(false, "Unsupported number of incorrect guesses!")
            return
        }
    }

    
}
