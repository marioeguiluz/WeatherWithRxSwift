//
//  OpenWeatherMapService.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import RxSwift

final class OpenWeatherMapService: WeatherService, ReactiveCompatible {
    private let networkLayer: NetworkLayer
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func getWeatherDetails(query: String) -> Observable<WeatherResult> {
        return Observable.create { observer in
            let request = self.getWeatherDetails(query: query, callback: { result in
                observer.onNext(WeatherResult(with: result))
            })
            return Disposables.create {
                request.cancel()
            }
        }.observeOn(MainScheduler.instance)
    }
    
    func getWeatherForCities(inEurope: Bool) -> Observable<[CityWeatherCellModel]> {
        return Observable.create { observer in
            let request = self.getWeatherForCities(inEurope: inEurope, callback: { result in
                switch result {
                case .success(let weatherList):
                    guard let list = weatherList.list else {
                        observer.onNext([])
                        return
                    }
                    observer.onNext(list.compactMap ({ CityWeatherCellModel(with: $0)}) )
                case .failure(_):
                    observer.onNext([])
                }
            })
            return Disposables.create {
                request.cancel()
            }
            }.observeOn(MainScheduler.instance)
    }
}

extension OpenWeatherMapService {
    private var baseURL: String { return "http://api.openweathermap.org/data/2.5/" }
    private var openWeatherMapKey: String { return "d62caae37d4c67c3c6d9871a3f00482f" }
    
    private func getWeatherDetails(query: String, callback: @escaping (Result<WeatherDetails>) -> Void) -> URLSessionDataTask {
        let encodedQuery = encode(query: query) ?? ""
        let request = URLRequest(url: weatherURL(for: encodedQuery))
        let task = networkLayer.get(request: request, callback: callback)
        task.resume()
        return task
    }
    
    private func getWeatherForCities(inEurope: Bool, callback: @escaping (Result<WeatherDetailsList>) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: weatherURLCities(inEurope: inEurope))
        let task = networkLayer.get(request: request, callback: callback)
        task.resume()
        return task
    }
    
    private func weatherURL(for cityName: String) -> URL {
        guard let url = URL(string: "\(baseURL)weather?q=\(cityName)&units=metric&appid=\(openWeatherMapKey)") else {
            fatalError("\(#file): \(#function)")
        }
        return url
    }
    
    private func weatherURLCities(inEurope: Bool) -> URL {
        let cities: [String] = inEurope ? ["2643743", "6455259", "6359304"] : ["1733046", "1609350", "1880252"]
        var cityIDs = cities.first ?? ""
        for cityID in cities.dropFirst() {
            cityIDs = "\(cityIDs),\(cityID)"
        }
        guard let url = URL(string: "\(baseURL)group?id=\(cityIDs)&units=metric&appid=\(openWeatherMapKey)") else {
            fatalError("\(#file): \(#function)")
        }
        return url
    }
    
    private func encode(query: String) -> String? {
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.insert(charactersIn: " ")
        return query.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?
            .replacingOccurrences(of: " ", with: "+")
    }
}
