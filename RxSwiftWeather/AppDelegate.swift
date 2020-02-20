//
//  AppDelegate.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    private var appPresentationManager: AppPresentationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkLayer = URLSessionNetworkLayer()
        let service = OpenWeatherMapService(networkLayer: networkLayer)
        appPresentationManager = AppPresentationManager(window: window, service: service)
        appPresentationManager?.startWithTabBar()
        
        return true
    }
}
