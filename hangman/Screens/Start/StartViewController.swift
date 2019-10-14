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
    private lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

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
                    self.customView.customWordTextField.removeFromSuperview()
                } else {
                    self.customView.additionalContentStackView.addArrangedSubview(self.customView.customWordTextField)
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

        viewModel.warningMessage
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] warning in

            // remove any other warnings
            self?.customView.additionalContentStackView.arrangedSubviews
                .compactMap({ $0 as? MessageBox })
                .filter({ $0.style == .warning })
                .forEach({ $0.removeFromSuperview() })

            // if there is a warning
            if let warningMessage = warning {
                self?.notificationFeedbackGenerator.notificationOccurred(.warning)
                let newWarning = MessageBox(message: warningMessage, style: .warning)
                self?.customView.additionalContentStackView.insertArrangedSubview(newWarning, at: 0)
            }

        }).disposed(by: disposeBag)

        viewModel.errorMessage
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] error in

            // remove any other errors
            self?.customView.additionalContentStackView.arrangedSubviews
                .compactMap({ $0 as? MessageBox })
                .filter({ $0.style == .error })
                .forEach({ $0.removeFromSuperview() })

            // if there is a error
            if let errorMessage = error {
                self?.notificationFeedbackGenerator.notificationOccurred(.error)
                let newError = MessageBox(message: errorMessage, style: .error)
                self?.customView.additionalContentStackView.insertArrangedSubview(newError, at: 0)
            }

        }).disposed(by: disposeBag)
        
    }

}

