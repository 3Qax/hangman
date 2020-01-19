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

    let isHeadVisible = BehaviorRelay<Bool>(value: false)
    let isNeckVisible = BehaviorRelay<Bool>(value: false)
    let isCorpusVisible = BehaviorRelay<Bool>(value: false)
    let isLeftArmVisible = BehaviorRelay<Bool>(value: false)
    let isRightArmVisible = BehaviorRelay<Bool>(value: false)
    let isLeftHandVisible = BehaviorRelay<Bool>(value: false)
    let isRightHandVisible = BehaviorRelay<Bool>(value: false)
    let isLeftLegVisible = BehaviorRelay<Bool>(value: false)
    let isRightLegVisible = BehaviorRelay<Bool>(value: false)
    let isLeftFootVisible = BehaviorRelay<Bool>(value: false)
    let isRightFootVisible = BehaviorRelay<Bool>(value: false)

    // masked out word which player is trying to guess
    let maskedWord: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    // set of letters to display as already guessed
    let guessedLetters = BehaviorRelay<Set<Character>>(value: Set())

    let numberOfGuesses = BehaviorRelay<Int>(value: 0)
    let numberOfIncorrectGuesses = BehaviorRelay<Int>(value: 0)

    // onNext events are guesses, onCompletion is win, onError is lose
    let game = PublishSubject<Character>()

    private var word: String?
    private let model: GameModel
    private let disposableBag = DisposeBag()

    init(model: GameModel) {
        self.model = model

        model.originalWord.subscribe(
            onSuccess: { word in
                self.word = word
                // Masked the word initially
                self.maskedWord.accept(String(word.map({ return !$0.isWhitespace ? "_" : $0})))

                self.game
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { guessedLetter in
                    // MARK: Setup guess tracking and judging
                    self.numberOfGuesses.accept(self.numberOfGuesses.value + 1)
                    // if the original word contains that letter it's a correct guess
                    if !word.contains(guessedLetter) { self.numberOfIncorrectGuesses.accept(self.numberOfIncorrectGuesses.value + 1) }

                    // MARK: Setup unveiling letters in maskedWord
                    let tmpSet: Set<Character> = [guessedLetter]
                    assert(!self.guessedLetters.value.contains(guessedLetter), "Invalid state! Guessed already guessed letter!")
                    self.guessedLetters.accept(self.guessedLetters.value.union(tmpSet))

                    var updatedWord = word
                    Set(word).forEach({ letter in
                        // if the guessedLetters doesn't contain a particular letter
                        if !self.guessedLetters.value.contains(letter) && !letter.isWhitespace {
                            // replace all it occurrences with underscore
                            updatedWord = updatedWord.replacingOccurrences(of: String(letter), with: "_")
                        }
                    })
                    self.maskedWord.accept(updatedWord)
                }).disposed(by: self.disposableBag)

                self.maskedWord
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (maskedWord: String) in
                    // MARK: check if it's end of the game
                    let lettersInMaskedWord = Set(maskedWord.replacingOccurrences(of: "_", with: ""))
                    let lettersInOriginalWord = Set(word)
                    let numberOfGuessesNeededToWin = lettersInOriginalWord.symmetricDifference(lettersInMaskedWord).count
                    if numberOfGuessesNeededToWin == 0 { self.game.on(.completed) }
                }).disposed(by: self.disposableBag)
            },
            onError: { error in
                assert(false, error.localizedDescription)
            }
        ).disposed(by: disposableBag)

        numberOfIncorrectGuesses
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] number in
                if number == 11 {
                    self.isRightFootVisible.accept(true)
                    self.game.on(.error(NSError(domain: "", code: 0)))
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
            }
            ).disposed(by: disposableBag)
    }

    func generateSummary(didWin: Bool) -> SummaryModel {
        return SummaryModel(
            didWin: didWin,
            timeNeeded: TimeInterval.random(in: 1.0...120.0),
            guessedLetters: guessedLetters.value,
            wordToGuess: word!
        )
    }
}
