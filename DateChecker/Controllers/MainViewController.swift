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
    var arrayOfMonths: [(String, [DayAndBeer])] = []
    private let itemsPerRow: CGFloat = 8
    private let sectionInsets = UIEdgeInsets(
      top: 5.0,
      left: 2.0,
      bottom: 5.0,
      right: 2.0)

    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
                    // set collection view with data
                    self.getBeersOnMonth()
                    
                    self.activityIndicator.stopAnimating()
                    print("Data loaded from: \(NetworkConfiguration.apiUrl)")
                case .failure(let error):
                    print(error)
                    self.activityIndicator.stopAnimating()
                }
                
            }

        }
    }
    
    private func getBeersOnMonth() {
        guard let calendarModel = calendarModel else { return }
        arrayOfMonths = calendarModel.getBeersForMonth()
        collectionView.reloadData()
    }


}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.titleLabel.text = arrayOfMonths[indexPath.section].0
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfMonths.count
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayOfMonths[section].1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as? DateCell {
            let currentBeer = arrayOfMonths[indexPath.section].1[indexPath.row]
            cell.setCell(dayAndBeer: currentBeer)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentBeerAndDay = arrayOfMonths[indexPath.section].1[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let beerOnDateViewController = storyboard.instantiateViewController(identifier: "BeerOnDateViewController") as? BeerOnDateViewController else {
            return
        }
        beerOnDateViewController.currentBeer = currentBeerAndDay.beer
        navigationController?.pushViewController(beerOnDateViewController, animated: true)
    }
    
    
}

