//
//  WeatherViewController.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import UIKit

import RxSwift

final class WeatherViewController: UIViewController {
    let bag = DisposeBag()
    let presenter = WeatherPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewModel(forCity: "")
            .drive(onNext: { print($0) })
            .disposed(by: bag)
    }
}

