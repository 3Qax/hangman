//
//  UIView+Extension.swift
//  hangman
//
//  Created by Jakub Towarek on 11/10/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import UIKit

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }

    /// Snaps edges of the view to its superview.
    /// Method throws `NSLayoutConstraintError.superviewRequired` when `self` is not added to `superview`.
    ///
    /// - Returns: Array of constraints
    func constrainEdges(to view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard superview != nil else {
            fatalError("Unable to install constraint on view. Does the constraint reference something from outside the subtree of the view?")
        }

        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ]
    }

    /// Creates and returns a new view that does not convert the autoresizing mask into constraints.
    class func autoLayoutView() -> Self {
        return self.init().layoutable()
    }

    /// Configures an existing view to not convert the autoresizing mask into constraints and returns the view.
    @discardableResult func layoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Adds a list of views to the end of the receiver’s list of subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
