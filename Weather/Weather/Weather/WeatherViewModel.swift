//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

struct WeatherViewModel: Equatable {
    let location: String
    let temperature: String
    let humidity: String
    let pressure: String
    
    init(descriptor: WeatherDescriptor) {
        self.location = descriptor.location
        self.temperature = "\(descriptor.temperature)ºK"
        self.humidity = "\(descriptor.humidity)%"
        self.pressure = "\(descriptor.pressure) hPa"
    }

    static func ==(lhs: WeatherViewModel, rhs: WeatherViewModel) -> Bool {
        return lhs.location == rhs.location &&
            lhs.temperature == rhs.temperature &&
            lhs.humidity == rhs.humidity &&
            lhs.pressure == rhs.pressure
    }
}
