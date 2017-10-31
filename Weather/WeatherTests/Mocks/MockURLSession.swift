//
//  MockURLSession.swift
//  WeatherTests
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

@testable import Weather

final class MockURLSession: DataProvidable {
    var requested = false
    var data: Data?
    
    func rx_response(request: URLRequest) -> Observable<Data> {
        requested = true
        return Observable.just(Data())
    }
}
