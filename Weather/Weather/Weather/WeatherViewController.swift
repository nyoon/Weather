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

        setupViews()
        setupDataSource()
    }
    
    private func setupViews() {
        resultsTableView.rowHeight = 200
        
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherViewController.keyboardVisible(notification:)), name: .UIKeyboardWillShow, object: nil)
    }

    private func setupDataSource() {

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
    
    @objc func keyboardVisible(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            resultsTableView.contentInset = .zero
        } else {
            resultsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        resultsTableView.scrollIndicatorInsets = resultsTableView.contentInset
    }
}
