//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift
import RxCocoa

struct WeatherPresenter {
    private let interactor: CurrentWeatherInteractable
    
    init(interactor: CurrentWeatherInteractable = CurrentWeatherInteractor()) {
        self.interactor = interactor
    }
    
    func viewModel(forCities cities: [String]) -> Driver<[WeatherViewModel]> {
        return Observable
            .from(cities.map { self.fetchViewModel(for: $0) })
            .merge()
            .toArray()
            .asDriver(onErrorJustReturn: [])
    }

    private func fetchViewModel(for city: String) -> Observable<WeatherViewModel> {
        return interactor.fetchData(forCity: city)
            .map { WeatherViewModel(descriptor: $0) }
    }
}
