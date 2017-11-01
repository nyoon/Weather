//
//  WeatherPresenterSpec.swift
//  WeatherTests
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import Nimble
import Quick
import RxSwift
import RxCocoa
import SwiftyJSON

@testable import Weather

final class WeatherPresenterSpec: QuickSpec {
    override func spec() {
        describe("a weather presenter") {
            context("when getting weather view models for a city") {
                var descriptor: WeatherDescriptor!
                var mockCurrentWeatherInteractor: MockCurrentWeatherInteractor!

                beforeEach {
                    descriptor = WeatherDescriptor(location: "Paris", temperature: 100.0, humidity: 20.0, pressure: 80.0)
                    mockCurrentWeatherInteractor = MockCurrentWeatherInteractor(descriptor: descriptor)
                }

                it("should fetch data from the interactor") {
                    let sut = WeatherPresenter(interactor: mockCurrentWeatherInteractor)
                    _ = sut.viewModel(forCities: [""]).drive()

                    expect(mockCurrentWeatherInteractor.fetchedData).to(beTrue())
                }

                it("should return the test view model's formatted properties") {
                    let sut = WeatherPresenter(interactor: mockCurrentWeatherInteractor)

                    var captured: [WeatherViewModel]?
                    let expected = [WeatherViewModel(descriptor: descriptor)]

                    _ = sut.viewModel(forCities: ["Paris"]).drive(onNext: { captured = $0 })

                    expect(captured).to(equal(expected))
                }
            }
        }
    }
}
