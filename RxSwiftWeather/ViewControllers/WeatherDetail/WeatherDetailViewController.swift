//
//  WeatherDetailViewController.swift
//  RxSwiftWeather
//
//  Created by Mario Eguiluz on 30/11/2018.
//  Copyright © 2018 MEZ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class WeatherDetailViewController: UIViewController {
    
    private let viewModel: WeatherDetailViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var cityTextField: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = NSLocalizedString("Type a city (min 3 characters)", comment: "")
        textfield.font = UIFont.systemFont(ofSize: 20)
        textfield.textColor = .black
        return textfield
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupLayout()
        setupAppareance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        view.addSubview(cityTextField)
        view.addSubview(temperatureLabel)
        
        cityTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: cityTextField.leadingAnchor).isActive = true
    }
    
    private func setupAppareance() {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityTextField.rx.text
            .orEmpty
            .debounce(0.4, scheduler: MainScheduler.instance)
            .bind(to: viewModel.cityName)
            .disposed(by: disposeBag)
        
        Driver
            .of(viewModel.invalidQuery, viewModel.data)
            .merge()
            .drive(onNext: { [weak self] weatherResult in
                self?.temperatureLabel.text = weatherResult.text
            })
            .disposed(by: disposeBag)
    }
}
