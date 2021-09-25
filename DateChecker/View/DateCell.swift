//
//  DateCell.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/17/21.
//

import Foundation
import UIKit

class DateCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(dayAndBeer: DayAndBeer) {
        titleLabel.text = dayAndBeer.day
        if let _ = dayAndBeer.beer {
            backgroundColor = .systemGreen
        } else {
            backgroundColor = .systemRed
        }
    }
    
}
