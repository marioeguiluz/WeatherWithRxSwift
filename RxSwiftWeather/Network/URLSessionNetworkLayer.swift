//
//  URLSessionNetworkLayer.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation

final class URLSessionNetworkLayer: NetworkLayer {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func get<T: Decodable>(request: URLRequest, callback: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        let decoder = JSONDecoder()
        let task = session.dataTask(with: request) { data, URLResponse, error in
            if let httpResponse = URLResponse as? HTTPURLResponse, httpResponse.statusCode == 404 {
                callback(.failure(.notFound))
                return
            }
            
            guard error == nil else {
                callback(.failure(.networFailure(error!.localizedDescription)))
                return
            }
            
            guard
                let response = data.flatMap ({ try? decoder.decode(T.self, from: $0) })
                else {
                    callback(.failure(.parsingFailure))
                    return
            }
            callback(.success(response))
        }
        return task
    }
}
