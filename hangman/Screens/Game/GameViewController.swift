//
//  GameViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {

    private let customView: GameView
    private let viewModel: GameViewModel

    init() {

        self.customView = GameView()
        self.viewModel = GameViewModel()

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {

    }


}
