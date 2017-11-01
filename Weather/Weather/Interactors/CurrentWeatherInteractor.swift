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
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5/weather"
        static let apiKey = "6d7fda9d93b652f86761cd14c09d8635"
    }
    
    private let session: DataProvidable
    
    init(session: DataProvidable = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(forCity city: String) -> Observable<WeatherDescriptor> {
        guard let url = url(forCity: city) else { return .never() }
        let urlRequest = URLRequest(url: url)
        
        return session.rx_response(request: urlRequest)
            .map { data in
                let weather = Weather(data: data)
                let name = weather.name
                let main = weather.main
                
                return WeatherDescriptor(location: name, temperature: main.temperature, humidity: main.humidity, pressure: main.pressure)
            }
    }

    private func url(forCity city: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path

        let cityQuery = URLQueryItem(name: "q", value: city)
        urlComponents.queryItems = [cityQuery]

        let appIdQuery = URLQueryItem(name: "appId", value: Constants.apiKey)

        urlComponents.queryItems = [cityQuery, appIdQuery]

        return urlComponents.url
    }
}
