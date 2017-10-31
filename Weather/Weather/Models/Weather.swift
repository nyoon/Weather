//
//  Weather.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import SwiftyJSON

struct Weather {
    struct Coordinate {
        let longitude: Double
        let latitutde: Double
        
        init(_ json: JSON) {
            self.longitude = json["lon"].doubleValue
            self.latitutde = json["lat"].doubleValue
        }
    }
    
    struct WeatherCondition {
        let id: Int
        let main: String
        let description: String
        let icon: String
        
        init(_ json: JSON) {
            self.id = json["id"].intValue
            self.main = json["main"].stringValue
            self.description = json["description"].stringValue
            self.icon = json["icon"].stringValue
        }
    }
    
    struct Main {
        let temperature: Double
        let pressure: Double
        let humidity: Double
        let temperatureMin: Double
        let temperatureMax: Double
        
        init(_ json: JSON) {
            self.temperature = json["temp"].doubleValue
            self.pressure = json["pressure"].doubleValue
            self.humidity = json["humidity"].doubleValue
            self.temperatureMin = json["temp_min"].doubleValue
            self.temperatureMax = json["temp_max"].doubleValue
        }
    }
    
    struct Wind {
        let speed: Double
        let degrees: Double
        
        init(_ json: JSON) {
            self.speed = json["speed"].doubleValue
            self.degrees = json["deg"].doubleValue
        }
    }
    
    struct Clouds {
        let all: Double
        
        init(_ json: JSON) {
            self.all = json["all"].doubleValue
        }
    }
    
    struct System {
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Double
        let sunset: Double
        
        init(_ json: JSON) {
            self.type = json["type"].intValue
            self.id = json["id"].intValue
            self.message = json["message"].doubleValue
            self.country = json["country"].stringValue
            self.sunrise = json["sunrise"].doubleValue
            self.sunset = json["sunset"].doubleValue
        }
    }
    
    let coordinates: Coordinate
    let weatherConditions: [WeatherCondition]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dataCalculation: Int
    let system: System
    let id: Int
    let name: String
    let cod: Int
    
    init(data: Data) {
        let json = JSON(data: data)
        
        self.coordinates = Coordinate(json["coord"])
        self.weatherConditions = json["weather"].arrayValue.map { WeatherCondition($0) }
        self.base = json["base"].stringValue
        self.main = Main(json["main"])
        self.visibility = json["visibility"].intValue
        self.wind = Wind(json["wind"])
        self.clouds = Clouds(json["clouds"])
        self.dataCalculation = json["dt"].intValue
        self.system = System(json["sys"])
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.cod = json["cod"].intValue
    }
}
