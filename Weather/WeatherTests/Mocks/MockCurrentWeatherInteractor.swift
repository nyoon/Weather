//
//  MockCurrentWeatherInteractor.swift
//  WeatherTests
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

@testable import Weather

final class MockCurrentWeatherInteractor: CurrentWeatherInteractable {
    var fetchedData = false

    private let descriptor: WeatherDescriptor

    init(descriptor: WeatherDescriptor) {
        self.descriptor = descriptor
    }

    func fetchData(forCity city: String) -> Observable<WeatherDescriptor> {
        fetchedData = true
        return Observable.just(descriptor)
    }
}
