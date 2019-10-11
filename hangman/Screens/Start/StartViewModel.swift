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
    let areSettingsCorrect = BehaviorRelay<Bool>(value: true)

    // let isEasyModeOn = BehaviorSubject<Bool>(value: false)

    private let disposableBag = DisposeBag()

    init() {

        // Settings validation
        Observable.combineLatest(useRandomWord, customWord)
            .map({ usingRandomWord, customWord -> Bool in
                if usingRandomWord { return true
                } else { return self.validate(word: customWord)}
            })
            .subscribe(onNext: { areSettingCorrect in
                self.areSettingsCorrect.accept(areSettingCorrect)
            })
            .disposed(by: disposableBag)

    }


    private func validate(word: String) -> Bool {
        return word.count > 6 && word.allSatisfy({ $0.isLetter && $0.isASCII })
    }

}
