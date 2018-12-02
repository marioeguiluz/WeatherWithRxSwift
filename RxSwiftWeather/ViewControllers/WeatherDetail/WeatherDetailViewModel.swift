//
//  WeatherDetailViewModel.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 01/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class WeatherDetailViewModel {
    
    let cityName = BehaviorRelay(value: "")
    private let weatherService: WeatherService
    private static let minimumQueryCharacters = 3

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    lazy var data: Driver<WeatherResult> = {
        return self.cityName.asObservable()
            .filter(minimumQueryCharacters())
            .flatMapLatest(weatherService.getWeatherDetails)
            .asDriver(onErrorJustReturn: WeatherResult.genericError())
    }()
    
    lazy var invalidQuery: Driver<WeatherResult> = {
        return self.cityName.asObservable()
            .filter({ $0.count < WeatherDetailViewModel.minimumQueryCharacters })
            .map { _ in return WeatherResult.empty() }
            .asDriver(onErrorJustReturn: WeatherResult.empty())
    }()
    
    private func minimumQueryCharacters() -> (String) -> Bool {
        return { query in
            return query.count >= WeatherDetailViewModel.minimumQueryCharacters
        }
    }
}
