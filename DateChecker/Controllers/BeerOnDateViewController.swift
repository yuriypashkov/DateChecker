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
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    @IBOutlet weak var untappdButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    
    
    
    var currentBeer: BeerData?
    var currentBrewery: BreweryData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupData()
    }
    
    private func setupData() {
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
        if let previewImageURL = currentBeer.beerLabelPreviewURL {
            previewImageView.lazyLoadImageFromWeb(urlStr: previewImageURL)
        } else {
            previewImageView.image = UIImage(named: "beerImageError")
        }
        
        dateLabel.text = "\(currentBeer.beerDate ?? "Поле beerDate не заполнено")"
        beerNameLabel.text = "\(currentBeer.beerName ?? "Поле beerName не заполнено")"
        
        if let currentBrewery = currentBrewery {
            breweryNameLabel.text = "\(currentBrewery.breweryName ?? "Поле breweryName не заполнено")"
        } else {
            breweryNameLabel.text = "Для данного пива не найдена пивоварня"
        }
        
        beerTypeLabel.text = "\(currentBeer.beerType ?? "none beerType")"
        
        if let abv = currentBeer.beerABV {
            beerTypeLabel.text! += " · \(abv) ABV"
        } else {
            beerTypeLabel.text! += " · none ABV"
        }
        if let ibu = currentBeer.beerIBU {
            beerTypeLabel.text! += " · \(ibu) IBU"
        } else {
            beerTypeLabel.text! += " · none IBU"
        }
        
//        let backgroundQueue = DispatchQueue.global(qos: .background)
//        backgroundQueue.async {
//            print("SOME TEXT")
//        }
        
    }
    
    private func setUI() {
        dateLabel.textColor = .black
        beerNameLabel.textColor = UIColor(hex: "#232020")
        breweryNameLabel.textColor = UIColor(hex: "#3f3f3f")
        beerTypeLabel.textColor = UIColor(hex:"#464545")
        
        if let firstColorStr = currentBeer?.firstColor, let secondColorStr = currentBeer?.secondColor {
            ColorService.shared.setGradientBackgroundOnView(view: view, firstColor: UIColor(hex: firstColorStr), secondColor: UIColor(hex: secondColorStr), cornerRadius: 0)
        }
        
        beerLabelImageView.layer.shadowColor = UIColor.black.cgColor
        beerLabelImageView.layer.shadowRadius = 4.0
        beerLabelImageView.layer.shadowOpacity = 1.0
        beerLabelImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        beerLabelImageView.layer.masksToBounds = false
        
        previewImageView.layer.cornerRadius = previewImageView.frame.size.width / 2
        
        if currentBeer?.untappdURL == nil {
            untappdButton.setImageColor(color: .red)
        }
    }
    
    private func setWrongUI() {
        dateLabel.text = "НА ЭТУ ДАТУ ДАННЫХ НЕТ СОВСЕМ"
        beerNameLabel.alpha = 0
        beerTypeLabel.alpha = 0
        breweryNameLabel.alpha = 0
        beerLabelImageView.alpha = 0
        infoButton.alpha = 0
        untappdButton.alpha = 0
    }
    
    @IBAction func untappdButtonTap(_ sender: UIButton) {
        sender.pressedEffect(scale: 0.9) { [weak self] in
            guard let self = self else {return}
            if let untappdURL = self.currentBeer?.untappdURL {
                if let url = URL(string: untappdURL) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func infoButtonTap(_ sender: UIButton) {
        sender.pressedEffect(scale: 0.9) { [weak self] in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let infoViewController = storyboard.instantiateViewController(identifier: "InfoViewController") as? InfoViewController else {
                return
            }
            infoViewController.currentBeer = self.currentBeer
            infoViewController.currentBrewery = self.currentBrewery
            self.present(infoViewController, animated: true, completion: nil)
        }

    }
    

}
