//
//  MockedDispatcher.swift
//  hangmanUITests
//
//  Created by Jakub Towarek on 20/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import Foundation

typealias DataCompletion = (Data?, URLResponse?, NSError?) -> Void

class MockedURLSession: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockedDataTask(urlRequest: request, completion: completionHandler)
    }
}

class MockedDataTask: URLSessionDataTask {
    private let urlRequest: URLRequest
    private let completion: DataCompletion
    private let realSession = URLSession(configuration: .default)

    init(urlRequest: URLRequest, completion: @escaping DataCompletion) {
        self.urlRequest = urlRequest
        self.completion = completion
    }

    override func resume() {
        print(urlRequest.url!.absoluteString)
        guard let json = ProcessInfo.processInfo.environment["AAA"]
            else { fatalError()}

        let response = HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let data = json.data(using: .utf8)
        completion(data, response, nil)
    }
}

class MockedDispatcher: Dispatcher {

    private lazy var mockedUrlSession = MockedURLSession()

    func execute<T: Decodable>(urlRequest: URLRequest, completion: @escaping ((Result<T, Error>) -> Void)) {

        // Create dataTask with completion handler.
        let dataTask = mockedUrlSession.dataTask(with: urlRequest) { data, response, error in
            // Check if there was eny error and if so call completion with .failure response.
            if let error = error {
                completion(.failure(error))
            }
            // If there are no errors, unwrap data, decode it with a given Decodable type
            // and call completion depending on decoding's result.
            else if let data = data {
                do {
                    let encodable = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(encodable))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        // Resume the task.
        dataTask.resume()
    }
}
