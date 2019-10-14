//
//  StartView.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class StartView: UIView {

    let hangmanTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.allerDisplayName, size: 70)
        label.text = "HANGMAN"
        label.textColor = UIColor.defaultPurple
        return label
    }()
    let barImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "bar", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let folkImageView: UIImageView = {
        let image = UIImage(named: "folk")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let useRandomWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.allerDisplayName, size: 28)
        label.text = "RANDOM WORD"
        label.textColor = UIColor.defaultYellow
        return label
    }()
    let useRandomWordSwitch: UISwitch = {
        let swt = UISwitch()
        swt.onTintColor = UIColor.defaultYellow
        swt.isOn = true
        return swt
    }()
    let additionalContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    let customWordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.defaultBackground
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.defaultText.cgColor
        textField.textColor = .defaultPurple
        textField.placeholder = "Word to guess"
        textField.autocapitalizationType = .allCharacters
        return textField
    }()
    let playButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.defaultYellow
        button.setTitleColor(.white, for: .normal)
        button.setTitle("PLAY", for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 28)
        button.layer.cornerRadius = 25
        return button
    }()



    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.defaultBackground

        self.addSubview(hangmanTitle)
        hangmanTitle.translatesAutoresizingMaskIntoConstraints = false
        hangmanTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        hangmanTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true

        self.addSubview(barImageView)
        barImageView.translatesAutoresizingMaskIntoConstraints = false
        barImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        barImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        barImageView.topAnchor.constraint(equalTo: hangmanTitle.bottomAnchor, constant: 20).isActive = true

        self.addSubview(folkImageView)
        folkImageView.translatesAutoresizingMaskIntoConstraints = false
        folkImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        folkImageView.topAnchor.constraint(equalTo: barImageView.bottomAnchor, constant: -25).isActive = true
        folkImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true


        self.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        playButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        playButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        self.addSubview(additionalContentStackView)
        additionalContentStackView.translatesAutoresizingMaskIntoConstraints = false
        additionalContentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        additionalContentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        additionalContentStackView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -10).isActive = true

        additionalContentStackView.addArrangedSubview(customWordTextField)

        self.addSubview(useRandomWordLabel)
        useRandomWordLabel.translatesAutoresizingMaskIntoConstraints = false
        useRandomWordLabel.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 15).isActive = true
        useRandomWordLabel.bottomAnchor.constraint(equalTo: additionalContentStackView.topAnchor, constant: -10).isActive = true

        self.addSubview(useRandomWordSwitch)
        useRandomWordSwitch.translatesAutoresizingMaskIntoConstraints = false
        useRandomWordSwitch.trailingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: -5).isActive = true
        useRandomWordSwitch.centerYAnchor.constraint(equalTo: useRandomWordLabel.centerYAnchor).isActive = true

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
