//
//  NetworkLayer.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    func get<T: Decodable>(request: URLRequest, callback: @escaping (Result<T>) -> Void) -> URLSessionDataTask
}
