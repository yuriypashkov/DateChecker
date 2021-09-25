//
//  CalendarModel.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/16/21.
//

import Foundation

class CalendarModel {
    
    var beers: [BeerData] = []
    //let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    let months = ["Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    
    init(beerData: [BeerData]) {
        beers = beerData
    }
    
    func getBeersForMonth() -> [(String, [DayAndBeer])] {
        var result: [(String, [DayAndBeer])] = []

        for month in months {
            var tempArray: [DayAndBeer] = []
            
            for i in 1...getDaysInMonth(month: month) {
                let tempBeer = getBeerForDate(day: i, month: month)
                let tempBeerAndDay = DayAndBeer(day: String(i), beer: tempBeer)
                tempArray.append(tempBeerAndDay)
            }
            
            let tempTuple = (month, tempArray)
            result.append(tempTuple)
        }
        
        return result
    }
    
    private func getDaysInMonth(month: String) -> Int { // без високосных годов
        switch month {
        case "Январь", "Март", "Май", "Июль", "Август", "Октябрь", "Декабрь":
            return 31
        case "Февраль":
            return 28
        case "Апрель", "Июнь", "Сентябрь", "Ноябрь":
            return 30
        default:
            return 0
        }
    }
    
    // здесь костыль чтобы показывать месяцы с сентября. Переписать нормально - хайдить месяцы, в которых ВСЕ дни без пив. Если хоть один день заполнен - показать весь месяц
    private func getBeerForDate(day: Int, month: String) -> BeerData? {
        // сформировать строчку-дату для возврата пива
        var intMonth = 0
        for i in 0..<months.count {
            if months[i] == month {
                
                // для 12 месяцев
                //intMonth = i + 1
                
                // для 2021-го года начиная с сентября
                intMonth = i + 9
            }
        }
        let date = "\(day).\(intMonth).2021" // формируем даты для 2021-го года, дальше руками поменять на 2022
        if let beer = getBeerForStringDate(date: date) {
            return beer
        }
        return nil
    }
    
    private func getBeerForStringDate(date: String) -> BeerData? {
        for beer in beers {
            if beer.beerDate == date {
                return beer
            }
        }
        return nil
    }
    
}

