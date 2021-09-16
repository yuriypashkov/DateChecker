//
//  CalendarModel.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/16/21.
//

import Foundation

class CalendarModel {
    
    var beers: [BeerData] = []
    
    init(beerData: [BeerData]) {
        beers = beerData
    }
    
    func getBeersForMonth() -> [(String, [DayAndBeer])] {
        var result: [(String, [DayAndBeer])] = []
        let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        
        for month in months {
            let tempArray: [DayAndBeer] = [DayAndBeer(day: "1", beer: nil), DayAndBeer(day: "2", beer: nil)]
            let tempTuple = (month, tempArray)
            result.append(tempTuple)
        }
        
        return result
    }
    
}
