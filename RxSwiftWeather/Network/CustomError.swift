//
//  CustomError.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 01/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation

import Foundation

enum CustomError: Error {
    case networFailure(String)
    case parsingFailure
    case general(String)
    case notFound
}

extension CustomError: LocalizedError {
    func isNotFound() -> Bool {
        switch self {
        case .notFound:
            return true
        default:
            return false
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .networFailure(let description): return description
        case .parsingFailure: return NSLocalizedString("Error Parsing", comment: "")
        case .general(let description): return description
        case .notFound: return NSLocalizedString("Not Found 404", comment: "")
        }
    }
}
