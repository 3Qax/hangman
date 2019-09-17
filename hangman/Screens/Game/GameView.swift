//
//  GameView.swift
//  hangman
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

final class GameView: UIView {

    let barImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "bar", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()


    // folk
    let folkWrapper: UIView = {
        let view = UIView()
        return view
    }()
    let headImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "head", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let neckImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "neck", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let corpusImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "corpus", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let leftArmImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "left-arm", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let rightArmImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "right-arm", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let leftHandImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "left-hand", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let rightHandImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "right-hand", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let leftLegImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "left-leg", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let rightLegImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "right-leg", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let leftFootImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "left-foot", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    let rightFootImageView: UIImageView = {
        let bundle = Bundle(identifier: "Hangman")
        let image = UIImage(named: "right-foot", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()

    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.allerDisplayName, size: 60)
        label.textAlignment = .center
        label.textColor = UIColor.defaultPurple
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let verticalKeyboardStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    let firstRowOfKeyboard: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        return stackView
    }()
    let letterAButton: UIButton = {
        let button = UIButton()
        button.setTitle("A", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterBButton: UIButton = {
        let button = UIButton()
        button.setTitle("B", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterCButton: UIButton = {
        let button = UIButton()
        button.setTitle("C", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterDButton: UIButton = {
        let button = UIButton()
        button.setTitle("D", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterEButton: UIButton = {
        let button = UIButton()
        button.setTitle("E", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterFButton: UIButton = {
        let button = UIButton()
        button.setTitle("F", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterGButton: UIButton = {
        let button = UIButton()
        button.setTitle("G", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterHButton: UIButton = {
        let button = UIButton()
        button.setTitle("H", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterIButton: UIButton = {
        let button = UIButton()
        button.setTitle("I", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterJButton: UIButton = {
        let button = UIButton()
        button.setTitle("J", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()

    let secondRowOfKeyboard: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    let letterKButton: UIButton = {
        let button = UIButton()
        button.setTitle("K", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterLButton: UIButton = {
        let button = UIButton()
        button.setTitle("L", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterMButton: UIButton = {
        let button = UIButton()
        button.setTitle("M", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterNButton: UIButton = {
        let button = UIButton()
        button.setTitle("N", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterOButton: UIButton = {
        let button = UIButton()
        button.setTitle("O", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterPButton: UIButton = {
        let button = UIButton()
        button.setTitle("P", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterQButton: UIButton = {
        let button = UIButton()
        button.setTitle("Q", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterRButton: UIButton = {
        let button = UIButton()
        button.setTitle("R", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterSButton: UIButton = {
        let button = UIButton()
        button.setTitle("S", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()

    let thirdRowOfKeyboard : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    let letterTButton: UIButton = {
        let button = UIButton()
        button.setTitle("T", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterUButton: UIButton = {
        let button = UIButton()
        button.setTitle("U", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterVButton: UIButton = {
        let button = UIButton()
        button.setTitle("V", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterWButton: UIButton = {
        let button = UIButton()
        button.setTitle("W", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterXButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterYButton: UIButton = {
        let button = UIButton()
        button.setTitle("Y", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()
    let letterZButton: UIButton = {
        let button = UIButton()
        button.setTitle("Z", for: .normal)
        button.backgroundColor = UIColor.defaultText
        button.titleLabel?.font = UIFont(name: UIFont.allerDisplayName, size: 22.0)
        button.layer.cornerRadius = 8
        return button
     }()




    init() {

        super.init(frame: .zero)
        self.backgroundColor = .defaultBackground


        self.addSubview(barImageView)
        barImageView.translatesAutoresizingMaskIntoConstraints = false
        barImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        barImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        barImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true

        self.addSubview(folkWrapper)
        folkWrapper.translatesAutoresizingMaskIntoConstraints = false
        folkWrapper.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true

        folkWrapper.addSubview(headImageView)
        headImageView.translatesAutoresizingMaskIntoConstraints = false
        headImageView.topAnchor.constraint(equalTo: folkWrapper.topAnchor, constant: 0).isActive = true
        headImageView.centerXAnchor.constraint(equalTo: folkWrapper.centerXAnchor, constant: 0).isActive = true

        folkWrapper.insertSubview(neckImageView, belowSubview: headImageView)
        neckImageView.translatesAutoresizingMaskIntoConstraints = false
        neckImageView.topAnchor.constraint(equalTo: headImageView.bottomAnchor, constant: -30).isActive = true
        neckImageView.centerXAnchor.constraint(equalTo: folkWrapper.centerXAnchor, constant: 0).isActive = true

        folkWrapper.insertSubview(corpusImageView, aboveSubview: neckImageView)
        corpusImageView.translatesAutoresizingMaskIntoConstraints = false
        corpusImageView.topAnchor.constraint(equalTo: neckImageView.bottomAnchor, constant: -10).isActive = true
        corpusImageView.centerXAnchor.constraint(equalTo: folkWrapper.centerXAnchor, constant: 0).isActive = true

        folkWrapper.insertSubview(leftArmImageView, belowSubview: corpusImageView)
        leftArmImageView.translatesAutoresizingMaskIntoConstraints = false
        leftArmImageView.topAnchor.constraint(equalTo: corpusImageView.topAnchor, constant: 0).isActive = true
        leftArmImageView.trailingAnchor.constraint(equalTo: corpusImageView.leadingAnchor, constant: 45).isActive = true

        folkWrapper.insertSubview(leftHandImageView, belowSubview: leftArmImageView)
        leftHandImageView.translatesAutoresizingMaskIntoConstraints = false
        leftHandImageView.centerYAnchor.constraint(equalTo: leftArmImageView.bottomAnchor, constant: -10).isActive = true
        leftHandImageView.leadingAnchor.constraint(equalTo: leftArmImageView.leadingAnchor, constant: -5).isActive = true

        folkWrapper.insertSubview(rightArmImageView, belowSubview: corpusImageView)
        rightArmImageView.translatesAutoresizingMaskIntoConstraints = false
        rightArmImageView.topAnchor.constraint(equalTo: corpusImageView.topAnchor, constant: 0).isActive = true
        rightArmImageView.leadingAnchor.constraint(equalTo: corpusImageView.trailingAnchor, constant: -45).isActive = true

        folkWrapper.insertSubview(rightHandImageView, belowSubview: rightArmImageView)
        rightHandImageView.translatesAutoresizingMaskIntoConstraints = false
        rightHandImageView.centerYAnchor.constraint(equalTo: rightArmImageView.bottomAnchor, constant: -10).isActive = true
        rightHandImageView.trailingAnchor.constraint(equalTo: rightArmImageView.trailingAnchor, constant: 5).isActive = true

        folkWrapper.insertSubview(leftLegImageView, belowSubview: corpusImageView)
        leftLegImageView.translatesAutoresizingMaskIntoConstraints = false
        leftLegImageView.topAnchor.constraint(equalTo: corpusImageView.bottomAnchor, constant: -20).isActive = true
        leftLegImageView.trailingAnchor.constraint(equalTo: corpusImageView.leadingAnchor, constant: 50).isActive = true

        folkWrapper.insertSubview(leftFootImageView, belowSubview: leftLegImageView)
        leftFootImageView.translatesAutoresizingMaskIntoConstraints = false
        leftFootImageView.bottomAnchor.constraint(equalTo: leftLegImageView.bottomAnchor, constant: 15).isActive = true
        leftFootImageView.trailingAnchor.constraint(equalTo: leftLegImageView.leadingAnchor, constant: 40).isActive = true

        folkWrapper.insertSubview(rightLegImageView, belowSubview: corpusImageView)
        rightLegImageView.translatesAutoresizingMaskIntoConstraints = false
        rightLegImageView.topAnchor.constraint(equalTo: corpusImageView.bottomAnchor, constant: -20).isActive = true
        rightLegImageView.leadingAnchor.constraint(equalTo: corpusImageView.trailingAnchor, constant: -50).isActive = true

        folkWrapper.insertSubview(rightFootImageView, belowSubview: rightLegImageView)
        rightFootImageView.translatesAutoresizingMaskIntoConstraints = false
        rightFootImageView.bottomAnchor.constraint(equalTo: rightLegImageView.bottomAnchor, constant: 15).isActive = true
        rightFootImageView.leadingAnchor.constraint(equalTo: rightLegImageView.trailingAnchor, constant: -40).isActive = true

        folkWrapper.bottomAnchor.constraint(equalTo: rightFootImageView.bottomAnchor, constant: 0).isActive = true
        folkWrapper.leadingAnchor.constraint(equalTo: leftHandImageView.leadingAnchor, constant: 0).isActive = true
        folkWrapper.trailingAnchor.constraint(equalTo: rightHandImageView.trailingAnchor, constant: 0).isActive = true

        self.addSubview(verticalKeyboardStack)
        verticalKeyboardStack.translatesAutoresizingMaskIntoConstraints = false
        verticalKeyboardStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        verticalKeyboardStack.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        verticalKeyboardStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        verticalKeyboardStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        verticalKeyboardStack.addArrangedSubview(firstRowOfKeyboard)
        verticalKeyboardStack.addArrangedSubview(secondRowOfKeyboard)
        verticalKeyboardStack.addArrangedSubview(thirdRowOfKeyboard)


        firstRowOfKeyboard.addArrangedSubview(letterAButton)
        firstRowOfKeyboard.addArrangedSubview(letterBButton)
        firstRowOfKeyboard.addArrangedSubview(letterCButton)
        firstRowOfKeyboard.addArrangedSubview(letterDButton)
        firstRowOfKeyboard.addArrangedSubview(letterEButton)
        firstRowOfKeyboard.addArrangedSubview(letterFButton)
        firstRowOfKeyboard.addArrangedSubview(letterGButton)
        firstRowOfKeyboard.addArrangedSubview(letterHButton)
        firstRowOfKeyboard.addArrangedSubview(letterIButton)
        firstRowOfKeyboard.addArrangedSubview(letterJButton)

        secondRowOfKeyboard.addArrangedSubview(letterKButton)
        secondRowOfKeyboard.addArrangedSubview(letterLButton)
        secondRowOfKeyboard.addArrangedSubview(letterMButton)
        secondRowOfKeyboard.addArrangedSubview(letterNButton)
        secondRowOfKeyboard.addArrangedSubview(letterOButton)
        secondRowOfKeyboard.addArrangedSubview(letterPButton)
        secondRowOfKeyboard.addArrangedSubview(letterQButton)
        secondRowOfKeyboard.addArrangedSubview(letterRButton)
        secondRowOfKeyboard.addArrangedSubview(letterSButton)

        thirdRowOfKeyboard.addArrangedSubview(letterTButton)
        thirdRowOfKeyboard.addArrangedSubview(letterUButton)
        thirdRowOfKeyboard.addArrangedSubview(letterVButton)
        thirdRowOfKeyboard.addArrangedSubview(letterWButton)
        thirdRowOfKeyboard.addArrangedSubview(letterXButton)
        thirdRowOfKeyboard.addArrangedSubview(letterYButton)
        thirdRowOfKeyboard.addArrangedSubview(letterZButton)

        self.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: verticalKeyboardStack.topAnchor, constant: -20).isActive = true
        

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
