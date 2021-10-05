//
//  InfoViewController.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/25/21.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var specialDateNameLabel: UILabel!
    @IBOutlet weak var aboutSpecialDateLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var aboutBeerLabel: UILabel!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var aboutBreweryLabel: UILabel!
    @IBOutlet weak var breweryLogoImageView: UIImageView!
    
    @IBOutlet weak var siteButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    @IBOutlet weak var vkButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var untappdButton: UIButton!
    
    var currentBeer: BeerData?
    var currentBrewery: BreweryData?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setUI()
    }
    
    private func setupData() {
        if let beer = currentBeer {
            beerNameLabel.text = beer.beerName
            aboutBeerLabel.text = beer.beerDescription
            specialDateNameLabel.text = beer.beerSpecialInfoTitle
            aboutSpecialDateLabel.text = beer.beerSpecialInfo
        }
        
        if let brewery = currentBrewery {
            breweryNameLabel.text = brewery.breweryName
            aboutBreweryLabel.text = brewery.aboutBrewery
            if let url = brewery.logoURL {
                breweryLogoImageView.lazyLoadImageFromWeb(urlStr: url)
            }
        }
    }
    
    private func setUI() {
        if currentBrewery?.siteURL == nil {
            //siteButton.isHidden = true
            //siteButton.tintColor = .red
            siteButton.setImageColor(color: .red)
        }
        if currentBrewery?.instaURL == nil {
            //instaButton.isHidden = true
            //instaButton.tintColor = .red
            instaButton.setImageColor(color: .red)
        }
        if currentBrewery?.vkURL == nil {
            //vkButton.isHidden = true
            //vkButton.tintColor = .red
            vkButton.setImageColor(color: .red)
        }
        if currentBrewery?.fbURL == nil {
            //fbButton.isHidden = true
            //fbButton.tintColor = .red
            fbButton.setImageColor(color: .red)
        }
        if currentBrewery?.untappdURL == nil {
            //untappdButton.isHidden = true
            //untappdButton.tintColor = .red
            untappdButton.setImageColor(color: .red)
        }
        if let firstColorStr = currentBeer?.firstColor, let secondColorStr = currentBeer?.secondColor {
        ColorService.shared.setGradientBackgroundOnView(view: view, firstColor: UIColor(hex: secondColorStr), secondColor: UIColor(hex: firstColorStr), cornerRadius: 0)
        }
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        sender.pressedEffect(scale: 0.9) { [weak self] in
            guard let self = self else {return}
            switch sender.tag {
            case 0:
                if let urlStr = self.currentBrewery?.siteURL {
                    self.openURL(urlStr: urlStr)
                }
            case 1:
                if let urlStr = self.currentBrewery?.instaURL {
                    self.openURL(urlStr: urlStr)
                }
            case 2:
                if let urlStr = self.currentBrewery?.vkURL {
                    self.openURL(urlStr: urlStr)
                }
            case 3:
                if let urlStr = self.currentBrewery?.fbURL {
                    self.openURL(urlStr: urlStr)
                }
            case 4:
                if let urlStr = self.currentBrewery?.untappdURL {
                    self.openURL(urlStr: urlStr)
                }
            default: ()
            }
        }

    }
    
    private func openURL(urlStr: String) {
        if let url = URL(string: urlStr) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    

}
