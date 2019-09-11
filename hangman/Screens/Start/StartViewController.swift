//
//  StartViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {

    private var customView: StartView
    private var viewModel: StartViewModel

    init() {

        self.customView = StartView()
        self.viewModel = StartViewModel()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

