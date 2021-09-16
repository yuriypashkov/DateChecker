//
//  ViewController.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/16/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView()
    var calendarModel: CalendarModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        
        getBeerData()
    }
    
    private func prepare() {
        activityIndicator.center = view.center
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func getBeerData() {
        activityIndicator.startAnimating()
        
        NetworkService.shared.requestBeerData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let beerArray):
                    
                    // create calendar model
                    self.calendarModel = CalendarModel(beerData: beerArray)
                    // print test beers
                    self.getBeersOnMonth()
                    
                    self.activityIndicator.stopAnimating()
                case .failure(let error):
                    print(error)
                    self.activityIndicator.stopAnimating()
                }
                
            }

        }
    }
    
    private func getBeersOnMonth() {
        guard let calendarModel = calendarModel else { return }
        let array = calendarModel.getBeersForMonth()
        for value in array {
            print("Month is \(value.0), and beers on day: \(value.1)")
        }
    }


}

