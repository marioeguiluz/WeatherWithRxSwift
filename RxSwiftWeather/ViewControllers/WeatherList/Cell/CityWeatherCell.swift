//
//  CityWeatherCell.swift
//  TheWeatherTurtle
//
//  Created by Mario Eguiluz on 12/02/2018.
//  Copyright © 2018 Red Turtle Technologies. All rights reserved.
//

import UIKit

final class CityWeatherCell: UITableViewCell {

    static let identifier = "CityWeatherCell"
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewWeather.image = nil
        imageViewBackground.image = nil
    }
    
    func update(_ viewModel: CityWeatherCellModel) {
        labelCity.text = viewModel.city
        labelTemperature.text = viewModel.temperature
//        imageViewBackground.image = viewModel.temperatureCategory.cellBackgroundImage()
//        ImageDownloader.shared.setImage(from: viewModel.icon, completion: { [weak self] (image) in
//            self?.imageViewWeather.image = image
//        })
    }
}
