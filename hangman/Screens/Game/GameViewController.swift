//
//  GameViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol GameViewControllerDelegate: AnyObject {
    func didWinGame()
    func didLoseGame()
}

final class GameViewController: UIViewController {

    private let customView: GameView
    private let viewModel: GameViewModel
    private let disposableBag = DisposeBag()

    lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    weak var cordinator: GameViewControllerDelegate?

    init(gameModel: GameModel, cordinator: GameViewControllerDelegate) {

        self.customView = GameView()
        self.viewModel = GameViewModel(model: gameModel)

        self.cordinator = cordinator

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let letters = [customView.letterAButton,
                        customView.letterBButton,
                        customView.letterCButton,
                        customView.letterDButton,
                        customView.letterEButton,
                        customView.letterFButton,
                        customView.letterGButton,
                        customView.letterHButton,
                        customView.letterIButton,
                        customView.letterJButton,
                        customView.letterKButton,
                        customView.letterLButton,
                        customView.letterMButton,
                        customView.letterNButton,
                        customView.letterOButton,
                        customView.letterPButton,
                        customView.letterQButton,
                        customView.letterRButton,
                        customView.letterSButton,
                        customView.letterTButton,
                        customView.letterUButton,
                        customView.letterVButton,
                        customView.letterWButton,
                        customView.letterXButton,
                        customView.letterYButton,
                        customView.letterZButton]

        letters.forEach({ letter in
            letter.rx.tap
                .subscribe({ _ in self.didTapLetter(sender: letter) })
                .disposed(by: disposableBag)
        })

        viewModel.isHeadVisible
            .bind(to: customView.headImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isNeckVisible
            .bind(to: customView.neckImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isCorpusVisible
            .bind(to: customView.corpusImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isLeftArmVisible
            .bind(to: customView.leftArmImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isRightArmVisible
            .bind(to: customView.rightArmImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isLeftHandVisible
            .bind(to: customView.leftHandImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isRightHandVisible
            .bind(to: customView.rightHandImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isLeftLegVisible
            .bind(to: customView.leftLegImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isRightLegVisible
            .bind(to: customView.rightLegImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isLeftFootVisible
            .bind(to: customView.leftFootImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.isRightFootVisible
            .bind(to: customView.rightFootImageView.rx.isHidden)
            .disposed(by: disposableBag)

        viewModel.maskedWord
            .bind(to: customView.wordLabel.rx.text)
            .disposed(by: disposableBag)

    }

    override func viewWillAppear(_ animated: Bool) {
        let folksCorpusWidth = customView.corpusImageView.frame.width
        let screenSize = customView.frame.width
        let currentProportion = folksCorpusWidth / screenSize
        let designatedProportion: CGFloat = 0.15
        let scaleToSet = designatedProportion / currentProportion
        customView.folkWrapper.transform = CGAffineTransform(scaleX: scaleToSet, y: scaleToSet)
        customView.folkWrapper.topAnchor.constraint(equalTo: customView.barImageView.bottomAnchor,
                                                    constant: 0)
            .isActive = true

    }

    override func viewDidAppear(_ animated: Bool) {
//        customView.folkWrapper.transform = CGAffineTransform(scaleX: 2.0, y: 4.0)
    }


    func didTapLetter(sender: UIButton) {
        if viewModel.guess(letter: sender.titleLabel!.text!.first!) {
            notificationFeedbackGenerator.notificationOccurred(.success)
        } else {
            notificationFeedbackGenerator.notificationOccurred(.warning)
        }
        sender.isEnabled = false
        sender.alpha = 0.3
    }


}
