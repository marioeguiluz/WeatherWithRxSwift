//
//  AppPresentationManager.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 01/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import UIKit

final class AppPresentationManager {
    
    private weak var window: UIWindow?
    private let service: WeatherService
    private let tabController = UITabBarController()
    
    init(window: UIWindow?, service: WeatherService) {
        self.window = window
        self.service = service
        setupAppearance()
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().tintColor = .darkGray
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        UISearchBar.appearance().tintColor = .darkGray
        UITabBar.appearance().tintColor = .darkGray
        UITabBar.appearance().backgroundColor = .white
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func startWithTabBar() {
        let cityViewModel = WeatherDetailViewModel(weatherService: service)
        let cityViewController = WeatherDetailViewController(viewModel: cityViewModel)
        cityViewController.tabBarItem = UITabBarItem(title: "By City", image: nil, tag: 0)
        
        let listViewModel = WeatherListViewModel(weatherService: service)
        let listViewController = WeatherListViewController(viewModel: listViewModel)
        listViewController.tabBarItem = UITabBarItem(title: "By Continent", image: nil, tag: 1)
        
        tabController.viewControllers = [listViewController, cityViewController]
        setRootViewController(tabController)
    }
}
