//
//  GameModel.swift
//  hangman
//
//  Created by Jakub Towarek on 17/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation
import RxSwift

final class GameModel {

    private(set) lazy var originalWord: Single<String> = Single.create { [weak self] single in
        let disposable = Disposables.create()
        if let customWord = self?.customWord {
            single(.success(customWord))
        } else {
            let request = PuzzleRequest().asURLRequest()
            self?.dispatcher.execute(urlRequest: request) { (result: Result<PuzzleResponse, Error>) in
                switch result {
                case .success(let data): single(.success(data.puzzle))
                case .failure(let reason): single(.error(reason))
                }
            }
        }
        return disposable
    }

    private let dispatcher: Dispatcher
    private let customWord: String?

    init(word: String? = nil, dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        customWord = word
    }
}
