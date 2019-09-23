//
//  StartViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate: AnyObject {
    func startGame()
}
final class StartViewController: UIViewController {

    private var customView: StartView
    private var viewModel: StartViewModel

    weak var cordinator: StartViewControllerDelegate?

    init(cordinator: StartViewControllerDelegate) {

        self.customView = StartView()
        self.viewModel = StartViewModel()

        self.cordinator = cordinator

        super.init(nibName: nil, bundle: nil)

        customView.playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        customView.useRandomWordSwitch.addTarget(self, action: #selector(didSwitchUsingRandomWord(sender:)), for: .valueChanged)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.useRandomWord.bind({ useRandomWord in
            self.customView.useRandomWordLabelBottomToTopOfCustomWordTextField?.isActive = !useRandomWord
            self.customView.useRandomWordLabelBottomToTopOfPlayButtonConstraint?.isActive = useRandomWord
            self.customView.customWordTextField.isHidden = useRandomWord
        })
    }

    @objc func didTapPlayButton() {
        cordinator?.startGame()
    }

    @objc func didSwitchGameDifficulty() {

    }

    @objc func didSwitchUsingRandomWord(sender: UISwitch) {
        viewModel.useRandomWord.value = sender.isOn
    }

}

