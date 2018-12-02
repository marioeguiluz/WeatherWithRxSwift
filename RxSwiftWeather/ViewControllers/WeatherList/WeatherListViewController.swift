//
//  WeatherListViewController.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 02/12/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class WeatherListViewController: UIViewController {
    
    private let viewModel: WeatherListViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: CityWeatherCell.identifier, bundle: nil), forCellReuseIdentifier: CityWeatherCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "blackBackground"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Europe cities", "Asia cities"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupLayout()
        setupAppareance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupAppareance() {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex
            .debounce(0.4, scheduler: MainScheduler.instance)
            .map { $0 == 0 }
            .bind(to: viewModel.citiesInEurope)
            .disposed(by: disposeBag)
        
        viewModel
            .data
            .drive(tableView.rx
                .items(cellIdentifier: CityWeatherCell.identifier, cellType: CityWeatherCell.self)) { _ , model, cell in
                    cell.update(model)}
            .disposed(by: disposeBag)
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
