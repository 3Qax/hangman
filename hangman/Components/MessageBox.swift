//
//  MessageBox.swift
//  hangman
//
//  Created by Jakub Towarek on 14/10/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit


final class MessageBox: UIView {

    public enum Style {
        case warning
        case error
    }

    public let style: Style


    private let messageLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.allerDisplayName, size: 24)
        return label
    }()



    init(message: String, style: Style) {

        self.style = style

        super.init(frame: .zero)

        self.layer.cornerRadius = 10.0

        messageLabel.text = message.uppercased()
        self.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        self.backgroundColor = style == .warning ? .defaultWarningYellow : .red


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

