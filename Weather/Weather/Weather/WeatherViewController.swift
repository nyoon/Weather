//
//  WeatherViewController.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/30/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class WeatherViewController: UIViewController {
    let bag = DisposeBag()
    let presenter = WeatherPresenter()

    // MARK: Outlets

    @IBOutlet private var resultsTableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        resultsTableView.rowHeight = 200

        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .debug()
            .flatMapLatest { self.presenter.viewModel(forCities: $0.components(separatedBy: ",")) }
            .debug()
            .observeOn(MainScheduler.instance)

        searchResults
            .bind(to: resultsTableView.rx.items(cellIdentifier: "WeatherTableViewCell")) { (index, viewModel, cell) in
                guard let cell = cell as? WeatherTableViewCell else { return }
                cell.setup(for: viewModel)
            }
            .disposed(by: bag)
    }
}
