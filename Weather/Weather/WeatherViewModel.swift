//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

struct WeatherViewModel {
    private let location: String
    private let temperature: String
    private let humidity: String
    private let pressure: String
    
    init(descriptor: WeatherDescriptor) {
        self.location = descriptor.location
        self.temperature = "\(descriptor.temperature)ºK"
        self.humidity = "\(descriptor.humidity)%"
        self.pressure = "\(descriptor.pressure) hPa"
    }
}
