//
//  BeerData.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/16/21.
//

import Foundation

struct BeerData: Codable {
    
    var id: String?
    var beerDate: String?
    var beerName: String?
    var beerType: String?
    var beerABV: String?
    var beerIBU: String?
    var beerDescription: String?
    var beerLabelURL: String?
    var beerLabelPreviewURL: String?
    var untappdURL: String?
    var breweryID: Int?
    var comment: String?
    var firstColor: String?
    var secondColor: String?
    var beerSpecialInfoTitle: String?
    var beerSpecialInfo: String?
    
}


struct DayAndBeer {
    var day: String
    var beer: BeerData?
}
