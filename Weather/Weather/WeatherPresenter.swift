//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

struct WeatherPresenter {
    private let interactor: CurrentWeatherInteractor
    
    init(interactor: CurrentWeatherInteractor = CurrentWeatherInteractor()) {
        self.interactor = interactor
    }
    
    func viewModel(forCity city: String) -> Observable<WeatherViewModel> {
        return interactor.fetchData(forCity: city)
            .map { WeatherViewModel(descriptor: $0) }
    }
}
