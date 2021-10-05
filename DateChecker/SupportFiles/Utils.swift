//
//  Utils.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/25/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func lazyLoadImageFromWeb(urlStr: String) {
        let spinner = UIActivityIndicatorView()
        spinner.center = self.center
        spinner.color = .red
        spinner.hidesWhenStopped = true
        self.addSubview(spinner)
        spinner.startAnimating()
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        //print(data)
                        self.image = UIImage(data: data)
                        spinner.stopAnimating()
                    } else {
                        self.image = UIImage(named: "beerImageError")
                        spinner.stopAnimating()
                    }
                }
            }.resume()
        }
    }
    
}

extension UIColor {
    
    convenience init(hex: String) {
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                var int = UInt64()
                Scanner(string: hex).scanHexInt64(&int)
                let a, r, g, b: UInt64
                switch hex.count {
                case 3: // RGB (12-bit)
                    (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
                case 6: // RGB (24-bit)
                    (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
                case 8: // ARGB (32-bit)
                    (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
                default:
                    (a, r, g, b) = (255, 0, 0, 0)
                }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

extension UIButton {
    
    func pressedEffect(scale: CGFloat, _ myCompletion: @escaping  () -> Void) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { finished in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            } completion: { finished in
                myCompletion()
            }
        }
    }
    
    func setImageColor(color: UIColor) {
        //let origImage = UIImage(named: imageName)
        let origImage = self.image(for: .normal)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = .red
    }
}
