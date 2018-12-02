//
//  Result.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 01/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(CustomError)
}

extension Result {
    var value: T? {
        guard case let .success(value) = self else { return nil }
        return value
    }
    
    var error: CustomError? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}

extension Result {
    func map<U>(_ transform: (T) -> U) -> Result<U> {
        return flatMap { .success(transform($0)) }
    }
    
    func flatMap<U>(_ transform: (T) -> Result<U>) -> Result<U> {
        switch self {
        case let .success(value): return transform(value)
        case let .failure(error): return .failure(error)
        }
    }
}
