//
//  SettingViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

class SettingViewController: UIViewController {
    
    //  Variables
    @IBOutlet weak var decimalStepper: UIStepper!
    @IBOutlet weak var decimalLbl: UILabel!
    
    var decimalValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.decimalLbl.text = "2"
    }
    
    // setting stepper value to Round Decimal places
    @IBAction func decimalValueChange(_ sender: UIStepper) {
        decimalLbl.text = "\(Int(decimalStepper.value))"
        RoundDecimal.instance.roundDecimal = Int(decimalStepper.value)
    }
    
}
	
