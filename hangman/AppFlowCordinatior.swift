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
    private var rootViewController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let startViewController = StartViewController()
        rootViewController = UINavigationController(rootViewController: startViewController)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }


}
