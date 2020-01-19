//
//  SummaryViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import UIKit
import RxSwift

protocol SummaryViewControllerDelegate: AnyObject {
    func playAgain()
}

class SummaryViewController: ViewController<SummaryView> {

    let viewModel: SummaryViewModel
    let disposeBag = DisposeBag()

    weak var coordinator: SummaryViewControllerDelegate?

    init(viewModel: SummaryViewModel, coordinator: SummaryViewControllerDelegate) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(view: SummaryView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.resultLabel.text = viewModel.resultText
        customView.descriptionLabel.text = viewModel.descriptionText
        customView.playButton.rx.tap.subscribe({ [unowned self] _ in
            self.coordinator?.playAgain()
        }).disposed(by: disposeBag)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.shouldEmitConfetti { customView.emitConfetti() }
    }


}

extension UIImage {
    private static let configuration = UIImage.SymbolConfiguration(scale: .small)
    static let heart = UIImage(systemName: "heart.fill", withConfiguration: configuration)!
    static let star = UIImage(systemName: "star.fill", withConfiguration: configuration)!
    static let bolt = UIImage(systemName: "bolt.fill", withConfiguration: configuration)!
    static let square = UIImage(systemName: "square.fill", withConfiguration: configuration)!
    static let triangle = UIImage(systemName: "triangle.fill", withConfiguration: configuration)!
}

