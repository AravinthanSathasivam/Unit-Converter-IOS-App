//
//  Volume.swift
//  CW01
//
//  Created by user188409 on 3/15/21.
//

import Foundation

class Volume {
    
    var ukGallon : Double
    var ukPint : Double
    var f_ounce : Double // fluid ounce
    var litre : Double
    var mililitre: Double
    
    init(ukGallon: Double, ukPint: Double, f_ounce: Double, litre: Double,stone: Double, mililitre: Double){
        self.ukGallon = ukGallon
        self.ukPint = ukPint
        self.f_ounce = f_ounce
        self.litre = litre
        self.mililitre = mililitre
    }
    
    func getVolume() -> String {
        return "\(self.ukGallon) ukGallon | \(self.ukPint) ukPint | \(self.f_ounce) fl oz |\(self.litre) litre |\(self.mililitre) mililitre "
        
    }
    
}
