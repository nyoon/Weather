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
    
    func viewModel(forCity city: String) -> Driver<WeatherViewModel> {
        return interactor.fetchData(forCity: city)
            .asDriver(onErrorJustReturn: defaultWeatherDescriptor)
            .map { WeatherViewModel(descriptor: $0) }
    }

    private var defaultWeatherDescriptor: WeatherDescriptor {
        return WeatherDescriptor(location: "", temperature: 0, humidity: 0, pressure: 0)
    }
}
