//
//  Temperature.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/15/21.
//

import Foundation


class Temperature {
    
    var celsius : Double
    var fahrenheit : Double
    var kelvin : Double

    
    init(celsius: Double, fahrenheit: Double, kelvin: Double) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
    
    func getTemperature() -> String {
        return "\(self.celsius) celsius | \(self.fahrenheit) fahrenheit | \(self.kelvin) kelvin"
    }
}
