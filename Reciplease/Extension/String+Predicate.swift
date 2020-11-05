//
//  String+Predicate.swift
//  Reciplease
//
//  Created by mickael ruzel on 20/10/2020.
//

import Foundation

extension String {
    var transformToArray: [String] {
        self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter { !$0.isEmpty }
    }
}
