//
//  StartViewModel.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



final class StartViewModel {

    let useRandomWord = BehaviorRelay<Bool>(value: true)
    let customWord = PublishRelay<String>()

    let warningMessage = BehaviorRelay<String?>(value: nil)
    let errorMessage = BehaviorRelay<String?>(value: nil)

    let allowGameStart = BehaviorRelay<Bool>(value: true)

    private let disposableBag = DisposeBag()



    init() {

        // Settings validation
        Observable.combineLatest(useRandomWord, customWord)
            .map({ [weak self] usingRandomWord, customWord -> Bool in

                // make sure to not validate words from API (automatically generated)
                guard !usingRandomWord else { return true }

                // make sure that the word doesn't contain whitespaces
                guard customWord.allSatisfy({ !$0.isWhitespace }) else {

                    // otherwise block the ability to start the game and show error
                    self?.errorMessage.accept("The word cannot contain whitespaces")
                    return false

                }

                // make sure word doesn't contain other characters (for example digits) than ASCI letters
                guard customWord.allSatisfy({ $0.isLetter && $0.isASCII }) else {

                    // display error message and block ability to start the game
                    self?.errorMessage.accept("The word should consists only of english letters")
                    return false

                }

                // check whether all of the letter in a word are upper case letters
                if !customWord.allSatisfy({ $0.isUppercase }) {

                    // if they are not, it's not a breaking condition - just show a warning - it will by parsed in GameVM anyway
                    self?.warningMessage.accept("All of the letters should be upper case")

                } else { self?.warningMessage.accept(nil) }

                // make sure word is at least 6 character long
                guard customWord.count >= 6 else {

                    // otherwise block the ability to start the game and show error
                    self?.errorMessage.accept("The world should be at least 6 character long")
                    return false

                }

                // if all checks passed allow game to start and hide any messages
                self?.errorMessage.accept(nil)
                return true

            })
            .subscribe(onNext: { [weak self] allow in self?.allowGameStart.accept(allow) })
            .disposed(by: disposableBag)

    }
}
