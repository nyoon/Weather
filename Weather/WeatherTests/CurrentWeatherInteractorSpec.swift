//
//  CurrentWeatherInteractorSpec.swift
//  WeatherTests
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import Nimble
import Quick
import RxSwift
import SwiftyJSON

@testable import Weather

final class CurrentWeatherInteractorSpec: QuickSpec {
    override func spec() {
        context("when fetching data for a specific city") {
            var mockURLSession: MockURLSession!
            
            beforeEach {
                mockURLSession = MockURLSession()
            }
            
            it("should request data from the server to be true") {
                let sut = CurrentWeatherInteractor(session: mockURLSession)
                _ = sut.fetchData(forCity: "").subscribe()
                
                expect(mockURLSession.requested).to(beTrue())
            }
            
            it("should return a weather descriptor") {
                guard let path = Bundle.main.path(forResource: "MockWeatherAPI", ofType: "json") else { return }
                mockURLSession.data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let sut = CurrentWeatherInteractor(session: mockURLSession)
                
                var captured: WeatherDescriptor?
                let expected = WeatherDescriptor(location: "London", temperature: 280.32, humidity: 81, pressure: 1012)
                
                _ = sut.fetchData(forCity: "").subscribe(onNext: { captured = $0 })
                
                expect(captured).to(equal(expected))
            }
        }
    }
}
