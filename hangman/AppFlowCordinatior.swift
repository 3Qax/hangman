//
//  AppFlowCordinatior.swift
//  pokedex
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

    func startGame(word: String) {
        let gameViewController = GameViewController(gameModel: GameModel(originalWord: word),
                                                    coordinator: self)
        navigationController?.pushViewController(gameViewController, animated: true)
    }

}

extension AppFlowCoordinator: GameViewControllerDelegate {

    func didWinGame() {
        print("Congratulations!")
    }

    func didLoseGame() {
        print("Maybe next time!")
    }

}
