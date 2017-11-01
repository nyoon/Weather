//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    @IBOutlet private var pressureLabel: UILabel!

    func setup(for viewModel: WeatherViewModel) {
        cityNameLabel.text = viewModel.location
        temperatureLabel.text = viewModel.temperature
        humidityLabel.text = viewModel.humidity
        pressureLabel.text = viewModel.pressure
    }
}
