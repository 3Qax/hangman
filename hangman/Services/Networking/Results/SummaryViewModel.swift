//
//  SummaryViewModel.swift
//  hangman
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import Foundation
import RxSwift

class SummaryViewModel {

    lazy var resultText: String = model.didWin ? "YOU WON" : "YOU LOST"

    lazy var descriptionText: String = "IT TOOK YOU \(model.timeNeeded) SECONDS"

    lazy var shouldEmitConfetti: Bool = model.didWin

    private let model: SummaryModel

    init(model: SummaryModel) {
        self.model = model
    }
}
