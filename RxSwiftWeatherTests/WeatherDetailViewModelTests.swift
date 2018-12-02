//
//  WeatherDetailViewModelTests.swift
//  RxSwiftWeatherTests
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

@testable import RxSwiftWeather
import RxTest
import RxSwift
import XCTest

final class WeatherDetailViewModelTests: XCTestCase {
    
    private let service = MockWeatherService()
    private let disposeBag = DisposeBag()

    func testWeather_Success_Returns_Temperature() {
        let theExpectation = expectation(description: "Weather is 7C")
        let expectedResult = WeatherResult.success(text: "7C")
        service.weatherResult = expectedResult
        
        let viewModel = WeatherDetailViewModel(weatherService: service)
        viewModel.data.asObservable().subscribe(onNext: { result in
            switch result {
            case .error:
                XCTFail("Error")
            case .success(let text):
                XCTAssertEqual(text, expectedResult.text)
            }
            theExpectation.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.cityName.accept("London")
        wait(for: [theExpectation], timeout: 1)
    }
    
    func testWeather_Failure_Returns_Error() {
        let theExpectation = expectation(description: "General Error")
        let expectedResult = WeatherResult.error(text: "General Error")
        service.weatherResult = expectedResult
        
        let viewModel = WeatherDetailViewModel(weatherService: service)
        viewModel.data.asObservable().subscribe(onNext: { result in
            switch result {
            case .error(let text):
                XCTAssertEqual(text, expectedResult.text)
            case .success:
                XCTFail("Error")
            }
            theExpectation.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.cityName.accept("London")
        wait(for: [theExpectation], timeout: 1)
    }
}
