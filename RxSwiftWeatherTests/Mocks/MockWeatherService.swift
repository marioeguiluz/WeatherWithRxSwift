//
//  MockWeatherService.swift
//  RxSwiftWeatherTests
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

@testable import RxSwiftWeather
import RxTest
import RxSwift
import XCTest

final class MockWeatherService: WeatherService {
    
    var weatherResult: WeatherResult? = nil
    var cityWeatherCellModels: [CityWeatherCellModel] = []
    
    func getWeatherDetails(query: String) -> Observable<WeatherResult> {
        guard let result = weatherResult else {
            return Observable.just(WeatherResult.empty())
        }
        return Observable.just(result)
    }
    
    func getWeatherForCities(inEurope: Bool) -> Observable<[CityWeatherCellModel]> {
        return Observable.just(cityWeatherCellModels)
    }
}
