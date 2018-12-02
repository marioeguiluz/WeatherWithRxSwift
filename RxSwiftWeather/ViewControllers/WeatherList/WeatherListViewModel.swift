//
//  WeatherListViewModel.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class WeatherListViewModel {
    
    let citiesInEurope = BehaviorRelay(value: true)
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    lazy var data: Driver<[CityWeatherCellModel]> = {
        return self.citiesInEurope.asObservable()
            .flatMapLatest(weatherService.getWeatherForCities)
            .asDriver(onErrorJustReturn: [])
    }()
}
