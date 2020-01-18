//
//  AppFlowCoordinator.swift
//  hangman
//
//  Created by Jakub Towarek on 10/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class AppFlowCoordinator: Coordinator {

    let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let startViewController = StartViewController(coordinator: self)
        navigationController = UINavigationController(rootViewController: startViewController)
        navigationController?.navigationBar.isHidden = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

extension AppFlowCoordinator: StartViewControllerDelegate {

    func startGame(with configuration: GameConfiguration) {
        switch configuration {
        case .randomWord:
            let gameViewController = GameViewController(gameModel: GameModel(), coordinator: self)
            navigationController?.pushViewController(gameViewController, animated: true)
        case .custom(let word):
            let gameViewController = GameViewController(gameModel: GameModel(word: word), coordinator: self)
            navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
}

extension AppFlowCoordinator: GameViewControllerDelegate {

    func didWinGame() {
        print("Won a game!")
        navigationController?.popViewController(animated: true)
    }

    func didLoseGame() {
        print("Lost a game!")
        navigationController?.popViewController(animated: true)
    }
}
