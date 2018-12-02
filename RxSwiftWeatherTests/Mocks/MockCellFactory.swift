//
//  MockCellFactory.swift
//  RxSwiftWeatherTests
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

@testable import RxSwiftWeather

final class MockCellFactory {
    
    static func europeWeatherCells() -> [CityWeatherCellModel] {
        let cell1 = CityWeatherCellModel(id: "1", city: "London", temperature: "7", temperatureCategory: TemperatureCategory.low, detail: "Detail", longitude: 10, latitude: 10, icon: nil)
        let cell2 = CityWeatherCellModel(id: "2", city: "Paris", temperature: "9", temperatureCategory: TemperatureCategory.low, detail: "Detail", longitude: 11, latitude: 10, icon: nil)

        return [cell1, cell2]
    }
    
    static func asiaWeatherCells() -> [CityWeatherCellModel] {
        let cell1 = CityWeatherCellModel(id: "3", city: "Bangkok", temperature: "27", temperatureCategory: TemperatureCategory.high, detail: "Detail", longitude: 12, latitude: 10, icon: nil)
        let cell2 = CityWeatherCellModel(id: "4", city: "Kuala Lumpur", temperature: "29", temperatureCategory: TemperatureCategory.high, detail: "Detail", longitude: 13, latitude: 10, icon: nil)
        
        return [cell1, cell2]
    }
}
