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
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0, 0.7]
        self.layer.addSublayer(gradient)
    }
}
