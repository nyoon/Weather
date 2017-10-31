//
//  ViewController.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import UIKit

import RxSwift

final class ViewController: UIViewController {
    let bag = DisposeBag()
    let presenter = WeatherPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        presenter.viewModel(forCity: "")
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
    }
}

