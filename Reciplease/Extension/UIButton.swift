//
//  UIButton.swift
//  Reciplease
//
//  Created by mickael ruzel on 04/10/2020.
//

import UIKit

extension UIButton {
    
    func round(background color: UIColor, title: String?, textColor: UIColor) {
        self.layer.cornerRadius = 5
        self.backgroundColor = color
        self.titleLabel?.text = title
        self.titleLabel?.textColor = textColor
    }
}
