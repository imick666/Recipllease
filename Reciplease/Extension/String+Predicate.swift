//
//  String+Predicate.swift
//  Reciplease
//
//  Created by mickael ruzel on 20/10/2020.
//

import Foundation

extension String {
    var ingredientNameIsCorrect: Bool {
        let ingredient = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard ingredient != "" else {
            return false
        }
        guard ingredient.count > 3 else {
            return false
        }
        let filtre = "^(?=.*[@&é\"'(§è!çà)-_#,;:=?./+[0-9]]).{0,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", filtre)
        return !predicate.evaluate(with: self)
    }
    
    var transformToArray: [String] {
        self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter {!$0.isEmpty }
    }
}
