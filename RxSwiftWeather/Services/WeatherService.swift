//
//  WeatherAPIClient.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherService {
    func getWeatherDetails(query: String) -> Observable<WeatherResult>
    func getWeatherForCities(inEurope: Bool) -> Observable<[CityWeatherCellModel]>
}
