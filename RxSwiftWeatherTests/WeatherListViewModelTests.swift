//
//  WeatherListViewModelTests.swift
//  RxSwiftWeatherTests
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

@testable import RxSwiftWeather
import RxTest
import RxSwift
import XCTest

final class WeatherListViewModelTests: XCTestCase {
    
    private let service = MockWeatherService()
    private let disposeBag = DisposeBag()
    
    func testWeatherEuropeCities_Success_Returns_EuropeCells() {
        let theExpectation = expectation(description: "Weather in Europe")
        let expectedResult = MockCellFactory.europeWeatherCells()
        service.cityWeatherCellModels = expectedResult
        
        let viewModel = WeatherListViewModel(weatherService: service)
        viewModel.data.asObservable().skip(1).subscribe(onNext: { result in
            XCTAssert(result.elementsEqual(expectedResult))
            theExpectation.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.citiesInEurope.accept(true)
        wait(for: [theExpectation], timeout: 1)
    }
    
    func testWeatherAsiaCities_Success_Returns_AsiaCells() {
        let theExpectation = expectation(description: "Weather in Asia")
        let expectedResult = MockCellFactory.asiaWeatherCells()
        service.cityWeatherCellModels = expectedResult
        
        let viewModel = WeatherListViewModel(weatherService: service)
        viewModel.data.asObservable().skip(1).subscribe(onNext: { result in
            XCTAssert(result.elementsEqual(expectedResult))
            theExpectation.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.citiesInEurope.accept(false)
        wait(for: [theExpectation], timeout: 1)
    }
}
