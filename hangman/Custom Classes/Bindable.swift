//
//  Bindable.swift
//  hangman
//
//  Created by Jakub Towarek on 17/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import Foundation

final public class Bindable<T> {

    public var value: T { didSet { self.callback?(value) } }
    private var callback: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    public func bind(_ callback: @escaping (T) -> Void) {
        self.callback = callback
        self.callback?(value)
    }

}
