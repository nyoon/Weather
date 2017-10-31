//
//  URLSession+Rx.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

protocol DataProvidable {
    func rx_response(request: URLRequest) -> Observable<Data>
}

extension URLSession: DataProvidable { }

enum NetworkError: Error {
    case statusCode(code: Int)
}

extension URLSession {
    func rx_response(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = self.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    observer.onError(error)
                } else {
                    guard let response = response as? HTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }

                    if 200 ..< 300 ~= response.statusCode {
                        if let data = data {
                            observer.onNext(data)
                            observer.onCompleted()
                        }
                    } else {
                        observer.onError(NetworkError.statusCode(code: response.statusCode))
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create(with: task.cancel)
        }
    }
}
