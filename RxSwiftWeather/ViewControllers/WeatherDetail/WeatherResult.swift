//
//  WeatherResult.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 01/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation

enum WeatherResult {
    case success(text: String)
    case error(text: String)
    
    init(with result: Result<WeatherDetails>) {
        switch result {
        case .failure(let error):
            if error.isNotFound() {
                self = .error(text: NSLocalizedString("City not found", comment: ""))
            } else {
                self = .error(text: error.localizedDescription)
            }
        case .success(let weatherDetails):
            if let temperature = weatherDetails.main?.temp {
                self = .success(text: "\(temperature)C")
            } else {
                self = .success(text: "-")
            }
        }
    }
    
    static func empty() -> WeatherResult {
        return .success(text: "")
    }
    
    static func genericError() -> WeatherResult {
        return .error(text: NSLocalizedString("Something went wrong", comment: ""))
    }
}

extension WeatherResult {
    var text: String {
        switch self {
        case .error(let errorText):
            return errorText
        case .success(let text):
            return text
        }
    }
}
