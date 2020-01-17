//
//  Notification.swift
//  KeyboardTopLayoutGuide
//
//  Created by Patryk Kaczmarek on 19/12/2019.
//  Copyright © 2019 Patryk Kaczmarek. All rights reserved.
//

import UIKit

extension Notification {

    /// Defines the duration of keyboard animation.
    /// Nil if notification doesn't contain such info.
    var keyboardAnimationDuration: TimeInterval? {
        return (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }

    /// Defines the rectangle of keyboard.
    /// Nil if notification doesn't contain such info.
    var keyboardRect: CGRect? {
        return userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
}
