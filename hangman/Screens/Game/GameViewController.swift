//
//  GameViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func didWinGame()
    func didLoseGame()
}

final class GameViewController: UIViewController {

    private let customView: GameView
    private let viewModel: GameViewModel

    lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    weak var cordinator: GameViewControllerDelegate?

    init(gameModel: GameModel, cordinator: GameViewControllerDelegate) {

        self.customView = GameView()
        self.viewModel = GameViewModel(model: gameModel)

        self.cordinator = cordinator

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self

        customView.letterAButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterBButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterCButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterDButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterEButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterFButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterGButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterHButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterIButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterJButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterKButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterLButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterMButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterNButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterOButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterPButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterQButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterRButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterSButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterTButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterUButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterVButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterWButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterXButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterYButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)
        customView.letterZButton.addTarget(self, action: #selector(didTapLetter(sender:)), for: .touchUpInside)



    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isHeadVisible.bind({ isVisible in self.customView.headImageView.isHidden = !isVisible })
        viewModel.isNeckVisible.bind({ isVisible in self.customView.neckImageView.isHidden = !isVisible })
        viewModel.isCorpusVisible.bind({ isVisible in self.customView.corpusImageView.isHidden = !isVisible })
        viewModel.isLeftArmVisible.bind({ isVisible in self.customView.leftArmImageView.isHidden = !isVisible })
        viewModel.isRightArmVisible.bind({ isVisible in self.customView.rightArmImageView.isHidden = !isVisible })
        viewModel.isLeftHandVisible.bind({ isVisible in self.customView.leftHandImageView.isHidden = !isVisible })
        viewModel.isRightHandVisible.bind({ isVisible in self.customView.rightHandImageView.isHidden = !isVisible })
        viewModel.isLeftLegVisible.bind({ isVisible in self.customView.leftLegImageView.isHidden = !isVisible })
        viewModel.isRightLegVisible.bind({ isVisible in self.customView.rightLegImageView.isHidden = !isVisible })
        viewModel.isLeftFootVisible.bind({ isVisible in self.customView.leftFootImageView.isHidden = !isVisible })
        viewModel.isRightFootVisible.bind({ isVisible in self.customView.rightFootImageView.isHidden = !isVisible })

        viewModel.maskedWord.bind({ word in self.customView.wordLabel.text = word })

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


    @objc func didTapLetter(sender: UIButton) {
        viewModel.guess(letter: sender.titleLabel!.text!.first!)
        sender.isEnabled = false
        sender.alpha = 0.3
    }


}

extension GameViewController: GameViewModelDelegate {

    func didGuessIncorrectly() {
        notificationFeedbackGenerator.notificationOccurred(.warning)
    }

    func didGuessCorrectly() {
        notificationFeedbackGenerator.notificationOccurred(.success)
    }

    func gameOver() {

    }

}
