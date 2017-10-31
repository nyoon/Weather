//
//  CurrentWeatherInteractor.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

protocol CurrentWeatherInteractable {
    func fetchData(forCity city: String) -> Observable<WeatherDescriptor>
}

struct CurrentWeatherInteractor: CurrentWeatherInteractable {
    private struct Constants {
        static let urlString = "http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1"
    }
    
    private let session: DataProvidable
    
    init(session: DataProvidable = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(forCity city: String) -> Observable<WeatherDescriptor> {
        guard let url = URL(string: Constants.urlString) else { return .never() }
        let urlRequest = URLRequest(url: url)
        
        return session.rx_response(request: urlRequest)
            .map { data in
                let weather = Weather(data: data)
                let name = weather.name
                let main = weather.main
                
                return WeatherDescriptor(location: name, temperature: main.temperature, humidity: main.humidity, pressure: main.pressure)
            }
    }
}
