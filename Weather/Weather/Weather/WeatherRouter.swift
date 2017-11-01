//
//  WeatherRouter.swift
//  Weather
//
//  Created by Nicholas Yoon on 10/31/17.
//  Copyright © 2017 Nicholas Yoon. All rights reserved.
//

import UIKit

/// Currently unused atm, since no other presentation logic is in place.
/// This is just a sample place holder of how a router could be used, the router should only be used inside the presenter
/// if there is something that needs to be presented
/// Currently the stream inside the presenter is using a driver cause I rather not error and show a message everytime, since its making
/// so many fast requests as the user is typing, I rather just return an empty error

struct WeatherRouter {
    private weak var viewController: UIViewController?
    
    init(presenting viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func presentError(_ error: Error) {
        let alertController = ErrorBuilder(with: error).make()
        viewController?.present(alertController, animated: true)
    }
}

struct ErrorBuilder {
    private let error: Error
    
    init(with error: Error) {
        self.error = error
    }
    
    func make() -> UIAlertController {
        let vc = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .default))
        
        return vc
    }
}
