//
//  GameModel.swift
//  hangman
//
//  Created by Jakub Towarek on 17/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation

struct GameModel {

    private(set) var originalWord: String

    private let networkDispatcher = NetworkDispatcher()

    init(word: String? = nil) {
        if let word = word {
            originalWord = word
        } else {
            let request = PuzzleRequest().asURLRequest()
            networkDispatcher.execute(urlRequest: request) { (result: Result<PuzzleResponse, Error>) in
                // handle response
            }
            originalWord = "XD"
        }
    }
}
