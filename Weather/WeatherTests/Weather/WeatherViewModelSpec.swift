//
//  WeatherViewModelSpec.swift
//  WeatherTests
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import Nimble
import Quick

@testable import Weather

final class WeatherViewModelSpec: QuickSpec {
    override func spec() {
        describe("a weather view model") {
            var descriptor: WeatherDescriptor!
            var sut: WeatherViewModel!
            
            beforeEach {
                descriptor = WeatherDescriptor(location: "London", temperature: 100.0, humidity: 50.0, pressure: 30.0)
                sut = WeatherViewModel(descriptor: descriptor)
            }
            
            it("should properly return the location as the name") {
                expect(sut.location).to(equal("London"))
            }
            
            it("should properly format temperature in kelvins") {
                expect(sut.temperature).to(equal("100.0ºK"))
            }
            
            it("should properly format humidity in percentage") {
                expect(sut.humidity).to(equal("50.0%"))
            }
            
            it("should properly format pressure in hPA") {
                expect(sut.pressure).to(equal("30.0 hPa"))
            }
        }
    }
}
