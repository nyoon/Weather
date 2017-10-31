//
//  URLSession+Rx.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import RxSwift

enum NetworkError: Error {
    case statusCode(code: Int)
}

extension Reactive where Base: URLSession {
    public func response(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { (data, response, error) in
                
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
