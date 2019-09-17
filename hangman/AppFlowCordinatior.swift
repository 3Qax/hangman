//
//  AppFlowCordinatior.swift
//  pokedex
//
//  Created by Jakub Towarek on 10/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class AppFlowCordinatior: Coordinatior {

    let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let startViewController = StartViewController(cordinator: self)
        navigationController = UINavigationController(rootViewController: startViewController)
        navigationController?.navigationBar.isHidden = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

extension AppFlowCordinatior: StartViewControllerDelegate {

    func startGame() {
        let gameViewController = GameViewController(gameModel: GameModel(word: "TEST"),cordinator: self)
        navigationController?.pushViewController(gameViewController, animated: true)
    }

}

extension AppFlowCordinatior: GameViewControllerDelegate {

    func didWinGame() {
        print("Congratulations!")
    }

    func didLoseGame() {
        print("Maybe next time!")
    }

}
