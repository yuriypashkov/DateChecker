//
//  InfoViewController.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/25/21.
//

import UIKit

class BeerOnDateViewController: UIViewController {

    @IBOutlet weak var beerLabelImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    
    
    var currentBeer: BeerData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        guard let currentBeer = currentBeer else {
            setWrongUI()
            return
        }
        // дальше каждое поле проверяем вручную, если что-то некорректно - выведем это
        if let imageURL = currentBeer.beerLabelURL {
            beerLabelImageView.lazyLoadImageFromWeb(urlStr: imageURL)
        } else {
            beerLabelImageView.image = UIImage(named: "beerImageError")
        }
        
        if let beerDate = currentBeer.beerDate {
            dateLabel.text = beerDate
        } else {
            dateLabel.text = "Поле beerDate не заполнено"
        }
        
        if let beerName = currentBeer.beerName {
            beerNameLabel.text = beerName
        } else {
            beerNameLabel.text = "Поле beerName не заполнено"
        }
        
    }
    
    private func setWrongUI() {
        dateLabel.text = "НА ЭТУ ДАТУ ДАННЫХ НЕТ СОВСЕМ"
    }
    
    @IBAction func infoButtonTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let infoViewController = storyboard.instantiateViewController(identifier: "InfoViewController") as? InfoViewController else {
            return
        }
        present(infoViewController, animated: true, completion: nil)
    }
    

}
