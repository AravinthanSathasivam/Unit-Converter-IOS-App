//
//  Weight.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/15/21.
//

import Foundation

class Weight {
    
    var kg : Double
    var gram : Double
    var ounce : Double
    var pound : Double
    var stone: Double  // stone-pound
    var s_pound: Double // stone-pound
    
    init(kg: Double, gram: Double, ounce: Double, pound: Double,stone: Double, s_pound: Double){
        self.kg = kg
        self.gram = gram
        self.ounce = ounce
        self.pound = pound
        self.stone = stone
        self.s_pound = s_pound
    }
    
    func getWeight() -> String {
        return "\(self.kg) kg | \(self.gram) g | \(self.ounce) ounce |\(self.pound) pound |\(self.stone) stone and \(self.s_pound) pound "
        
    }
    
}
