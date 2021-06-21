//
//  Speed.swift
//  CW01
//
//  Created by Aravinthan on 3/15/21.
//

import Foundation

class Speed {
    
    var metre_Sec : Double // metres/sec
    var kilometre_Hour : Double //  km/hour
    var miles_Hour : Double  // miles/hour
    var knot : Double // nautical miles/hour

    
    init(metre_Sec: Double, kilometre_Hour: Double, miles_Hour: Double, knot: Double) {
        self.metre_Sec = metre_Sec
        self.kilometre_Hour = kilometre_Hour
        self.miles_Hour = miles_Hour
        self.knot = knot
    }
    
    func getSpeed() -> String {
        return "\(self.metre_Sec) m/s | \(self.kilometre_Hour) km/h | \(self.miles_Hour) miles/h |\(self.knot) kn "
        
    }
}
