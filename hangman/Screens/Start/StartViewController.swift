//
//  StartViewController.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol StartViewControllerDelegate: AnyObject {
    func startGame(word: String)
}

final class StartViewController: UIViewController {

    private var customView: StartView
    private var viewModel: StartViewModel
    
    private let disposeBag = DisposeBag()

    weak var cordinator: StartViewControllerDelegate?

    init(cordinator: StartViewControllerDelegate) {

        self.customView = StartView()
        self.viewModel = StartViewModel()

        self.cordinator = cordinator

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() { self.view = customView }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.useRandomWordSwitch.rx.isOn
            .bind(to: viewModel.useRandomWord)
            .disposed(by: disposeBag)

        customView.useRandomWordSwitch.rx.isOn
            .subscribe(onNext: { hideCustomWordTextField in
                if hideCustomWordTextField {
                    self.customView.customWordTextField.isHidden = true
                    self.customView.useRandomWordLabelBottomToTopOfCustomWordTextField?.isActive = false
                    self.customView.useRandomWordLabelBottomToTopOfPlayButtonConstraint?.isActive = true
                } else {
                    self.customView.customWordTextField.isHidden = false
                    self.customView.useRandomWordLabelBottomToTopOfPlayButtonConstraint?.isActive = false
                    self.customView.useRandomWordLabelBottomToTopOfCustomWordTextField?.isActive = true
                }
            }).disposed(by: disposeBag)

        customView.playButton.rx.tap
            // it's safe to force unwrap here since button cannot be tap when text is nil
            .subscribe({ [unowned self] _ in self.cordinator?.startGame(word: self.customView.customWordTextField.text!) })
            .disposed(by: disposeBag)


        viewModel.allowGameStart
            .subscribe(onNext: { areCorrect in
                self.customView.playButton.isEnabled = areCorrect
                self.customView.playButton
                    .backgroundColor = areCorrect ? UIColor.defaultYellow : UIColor.darkGray
            })
            .disposed(by: disposeBag)

        customView.customWordTextField.rx.text.orEmpty
            .bind(to: viewModel.customWord)
            .disposed(by: disposeBag)
        
    }

}

