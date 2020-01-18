//
//  PuzzleRequest.swift
//  hangman
//
//  Created by Jakub Towarek on 18/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import Foundation

struct PuzzleRequest: Request, URLRequestConvertible {

    var basePath: String { "http://puzzle.mead.io" }

    var apiPath: String { "/puzzle" }

    var path: String { "" }

    var method: HTTPMethod { .get }

    var body: [String : Any]?

    var parameters: [String : String]? { ["wordCount" : "1"] }

    var headers: [String : String]?

}
