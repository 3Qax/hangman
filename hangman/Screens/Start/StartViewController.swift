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

final class StartViewController: ViewController<StartView> {

    private var viewModel: StartViewModel
    
    private let disposeBag = DisposeBag()
    private lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    weak var coordinator: StartViewControllerDelegate?

    init(coordinator: StartViewControllerDelegate) {
        self.viewModel = StartViewModel()
        self.coordinator = coordinator
        super.init(view: StartView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHandling()

        customView.useRandomWordSwitch.rx.isOn
            .bind(to: viewModel.useRandomWord)
            .disposed(by: disposeBag)

        customView.useRandomWordSwitch.rx.isOn
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] useRandomWord in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.3,
                    delay: 0.0,
                    options: .curveLinear,
                    animations: {
                        self?.customView.additionalContentStackView
                                            .arrangedSubviews
                                            .forEach({ $0.isHidden = useRandomWord })
                })
            }).disposed(by: disposeBag)

        customView.playButton.rx.tap
            // it's safe to force unwrap here since button cannot be tap when text is nil
            .subscribe({ [unowned self] _ in self.coordinator?.startGame(word: self.customView.customWordTextField.text!) })
            .disposed(by: disposeBag)


        viewModel.allowGameStart
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { areCorrect in
                self.customView.playButton.isEnabled = areCorrect
                UIView.transition(
                    with: self.customView.playButton,
                    duration: 0.25,
                    options: .transitionCrossDissolve,
                    animations: {
                        self.customView.playButton.backgroundColor = areCorrect ? UIColor.defaultYellow : UIColor.darkGray
                })
            })
            .disposed(by: disposeBag)

        customView.customWordTextField.rx.text.orEmpty
            .bind(to: viewModel.customWord)
            .disposed(by: disposeBag)

        viewModel.warningMessage
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
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
                newWarning.isHidden = true
                self?.customView.additionalContentStackView.insertArrangedSubview(newWarning, at: 0)
                UIView.animate(withDuration: 0.3, animations: {
                    newWarning.isHidden = false
                })
            }

        }).disposed(by: disposeBag)

        viewModel.errorMessage
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
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
                newError.isHidden = true
                self?.customView.additionalContentStackView.insertArrangedSubview(newError, at: 0)
                UIView.animate(withDuration: 0.3, animations: {
                    newError.isHidden = false
                })
            }

        }).disposed(by: disposeBag)
    }

    private func setupKeyboardHandling() {
        automaticallyAdjustKeyboardLayoutGuide = true
        onKeyboardWillAppear = { _ in
            var leftTransform = CATransform3DIdentity
             leftTransform.m34 = -1.0/500.0
             leftTransform = CATransform3DRotate(leftTransform, .pi / 2, 0, 1, 0)
            UIView.animate(withDuration: 0.20, animations: {
                self.customView.folkImageView.transform = CGAffineTransform(scaleX: 0.000001, y: 0.000001)
                self.customView.barImageView.layer.transform = leftTransform
            })
        }
        onKeyboardWillDisappear = { _ in
            var leftTransform = CATransform3DIdentity
            leftTransform.m34 = -1.0/500.0
            UIView.animate(withDuration: 0.20, animations: {
                self.customView.folkImageView.transform = .identity
                self.customView.barImageView.layer.transform = leftTransform
            })
        }
    }

}

