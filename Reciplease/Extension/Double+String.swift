//
//  Double + String.swift
//  Reciplease
//
//  Created by mickael ruzel on 12/10/2020.
//

import Foundation
extension Double {
    
    var hhmmString: String {
        let minutesAsInt = Int(self)
        guard minutesAsInt != 0 else {
            return "N/C"
        }
        
        var formattedTime: (hour: Int, minutes: Int) {
            let hours = minutesAsInt / 60
            let minutes = minutesAsInt % 60
            return (hours, minutes)
        }
        
        let string = "\(formattedTime.hour)h\(formattedTime.minutes)m "
        
        return string
    }
    
}
