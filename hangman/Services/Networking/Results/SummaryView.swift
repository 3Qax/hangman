//
//  SummaryView.swift
//  hangman
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import UIKit

final class SummaryView: View {

    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.allerDisplayName, size: 70)
        label.textColor = UIColor.defaultYellow
        label.accessibilityIdentifier = AccessibilityIdentifiers.summaryScreenResultLabel
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.allerDisplayName, size: 28)
        label.textColor = UIColor.defaultPurple
        label.accessibilityIdentifier = AccessibilityIdentifiers.summaryScreenDescriptionLabel
        return label
    }()

    private lazy var confettiView = ConfettiView()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(resultLabel, descriptionLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    lazy var playButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.defaultYellow
        button.setTitleColor(.white, for: .normal)
        button.setTitle("TRY ONCE AGAIN", for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 28)
        button.layer.cornerRadius = 25
        button.accessibilityIdentifier = AccessibilityIdentifiers.summaryScreenPlayAgainButton
        return button
     }()


    override init() {
        super.init()

        addSubviews(contentStackView, confettiView, playButton)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        confettiView.translatesAutoresizingMaskIntoConstraints = false
        confettiView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        confettiView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        confettiView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        confettiView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        playButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func emitConfetti() {
        let colors: [UIColor] = [.red, .blue, .green, .yellow]
        let images: [UIImage] = [.heart, .star, .bolt, .square, .triangle]
        confettiView.emit(with: colors * images)
    }
}

infix operator *
func *(lhs: Array<UIColor>, rhs: Array<UIImage>) -> [(UIColor, UIImage)] {
    var result = [(UIColor, UIImage)]()
    for i in lhs {
        for j in rhs {
            result.append((i, j))
        }
    }
    return result
}

