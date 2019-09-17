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
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
    }

    @objc func didTapPlayButton() {
        cordinator?.startGame()
    }

}

