//
//  View + Gradient.swift
//  Reciplease
//
//  Created by mickael ruzel on 08/10/2020.
//

import Foundation
import UIKit

extension UIView {
    func createGradient(frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0.2145212293, green: 0.2007080019, blue: 0.1960143745, alpha: 1).cgColor]
        gradient.locations = [0, 0.8]
        self.layer.addSublayer(gradient)
    }
}
