//
//  GameViewModel.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



final class GameViewModel {

    enum GameErrors: Error {
        case letterAlreadyGuessed
        case endOfChances
    }

    public let isHeadVisible = BehaviorRelay<Bool>(value: false)
    public let isNeckVisible = BehaviorRelay<Bool>(value: false)
    public let isCorpusVisible = BehaviorRelay<Bool>(value: false)
    public let isLeftArmVisible = BehaviorRelay<Bool>(value: false)
    public let isRightArmVisible = BehaviorRelay<Bool>(value: false)
    public let isLeftHandVisible = BehaviorRelay<Bool>(value: false)
    public let isRightHandVisible = BehaviorRelay<Bool>(value: false)
    public let isLeftLegVisible = BehaviorRelay<Bool>(value: false)
    public let isRightLegVisible = BehaviorRelay<Bool>(value: false)
    public let isLeftFootVisible = BehaviorRelay<Bool>(value: false)
    public let isRightFootVisible = BehaviorRelay<Bool>(value: false)

    // masked out word which player is trying to guess
    public let maskedWord: BehaviorRelay<String>

    // set of letters to display as already guessed
    public let guessedLetters = BehaviorRelay<Set<Character>>(value: Set())

    public let numberOfGuesses = BehaviorRelay<Int>(value: 0)
    public let numberOfIncorrectGuesses = BehaviorRelay<Int>(value: 0)

    public let gameResult = PublishSubject<Result<Void, GameErrors>>()



    // representation of game
    // onNext events are guesses, onCompletion is win, onError is lose
    private let game = PublishSubject<Character>()

    private let model: GameModel
    private let disposableBag = DisposeBag()

    init(model: GameModel) {
        self.model = model

        let initialMask = String(model.originalWord.map({ return !$0.isWhitespace ? "_" : $0}))
        self.maskedWord = BehaviorRelay<String>(value: initialMask)

        // react to new guesses
        game.subscribe(onNext: { [unowned self] (newLetter: Character) in

            // FIXME: fix these two line piece of garbage
            let tmpSet: Set<Character> = [newLetter]
            self.guessedLetters.accept(self.guessedLetters.value.union(tmpSet))

            var updatedWord = model.originalWord

            // for each unique letter in String
            Set(model.originalWord).forEach({ letter in
                // if the guessedLetters doesn't contain a particular letter
                if !self.guessedLetters.value.contains(letter) && !letter.isWhitespace {
                    // replace all it occurrences with underscore
                    updatedWord = updatedWord.replacingOccurrences(of: String(letter), with: "_")
                }

            })

            self.maskedWord.accept(updatedWord)

        }).disposed(by: disposableBag)

        // update folk visibility according to number of incorrect guesses
        numberOfIncorrectGuesses.subscribe(onNext: { [unowned self] number in
            if number == 11 {
                self.isRightFootVisible.accept(true)
                self.gameResult.onNext(.failure(.endOfChances))
            }
            if number >= 10 { self.isLeftFootVisible.accept(true) }
            if number >= 9 { self.isRightLegVisible.accept(true) }
            if number >= 8 { self.isLeftLegVisible.accept(true) }
            if number >= 7 { self.isRightHandVisible.accept(true) }
            if number >= 6 { self.isLeftHandVisible.accept(true) }
            if number >= 5 { self.isRightArmVisible.accept(true) }
            if number >= 4 { self.isLeftArmVisible.accept(true) }
            if number >= 3 { self.isCorpusVisible.accept(true) }
            if number >= 2 { self.isNeckVisible.accept(true) }
            if number >= 1 { self.isHeadVisible.accept(true) }
        }).disposed(by: disposableBag)

    }

    /// Guess a letter by calling this function
    /// - Parameter letter: a letter to be guessed
    /// - Returns: Bool indicating wether a guess was correct or not
    public func guess(letter: Character) -> Bool {

        numberOfGuesses.accept(numberOfGuesses.value + 1)

        guard isCorrectGuess(letter) else {
            numberOfIncorrectGuesses.accept(numberOfIncorrectGuesses.value + 1)
            return false
        }

        game.onNext(letter)

        // check if it's end of the game
        if numberOfGuessesNeededToWin() == 0 { gameResult.onNext(.success(())) }

        return true

    }

    /// Checks wether letter is correct guess
    private func isCorrectGuess(_ letterToBeGuessed: Character) -> Bool {

        // make sure that the letter hasn't been already guessed
        guard !guessedLetters.value.contains(letterToBeGuessed) else {
            gameResult.onNext(.failure(.letterAlreadyGuessed))
            return false
        }

        // if the original word contains that letter it's a correct guess
        return model.originalWord.contains(letterToBeGuessed)

    }

    private func numberOfGuessesNeededToWin() -> Int {

        let lettersInMaskedWord = Set(maskedWord.value.replacingOccurrences(of: "_", with: ""))
        let lettersInOriginalWord = Set(model.originalWord)

        return lettersInOriginalWord.symmetricDifference(lettersInMaskedWord).count

    }
    
}
