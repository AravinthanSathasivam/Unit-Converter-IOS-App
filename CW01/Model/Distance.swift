//
//  Distance.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/15/21.
//

import Foundation

class Distance {
    
    var metre : Double
    var kilometre : Double
    var miles : Double
    var centimetre : Double
    var milimetre: Double
    var yard: Double
    var inch: Double

    
    init(metre: Double, kilometre: Double, miles: Double, centimetre: Double,milimetre: Double, yard: Double, inch: Double) {
        self.metre = metre
        self.kilometre = kilometre
        self.miles = miles
        self.centimetre = centimetre
        self.milimetre = milimetre
        self.yard = yard
        self.inch = inch
    }
    
    func getDistance() -> String {
        return "\(self.metre) m | \(self.kilometre) km | \(self.miles) miles |\(self.centimetre) cm |\(self.milimetre) mm |\(self.yard) yard |\(self.inch) inch "
        
    }
}
