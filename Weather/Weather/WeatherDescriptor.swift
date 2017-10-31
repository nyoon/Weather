//
//  WeatherDescriptor.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

struct WeatherDescriptor: Equatable {
    let location: String
    let temperature: Double
    let humidity: Double
    let pressure: Double
    
    static func ==(lhs: WeatherDescriptor, rhs: WeatherDescriptor) -> Bool {
        return lhs.location == rhs.location &&
            lhs.temperature == rhs.temperature &&
            lhs.humidity == rhs.humidity &&
            lhs.pressure == rhs.pressure
    }
}
