//
//  DistanceViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

enum DistanceScales: Int {
    case metre ,kilometre, miles, centimetre, milimetre, yard, inch
}

private let max_count = 5

class DistanceViewController: UIViewController , UITextFieldDelegate{
    // Custom-Keyboard - varaibles
    @IBOutlet weak var keyboardView: CustomKeyboard!
    // Textfields - variables
    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var kmTextField: UITextField!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var cmTextField: UITextField!
    @IBOutlet weak var mmTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    //creating an object - Distance
    var distance : Distance = Distance(metre: 0.0, kilometre: 0.0, miles: 0.0, centimetre: 0.0, milimetre: 0.0, yard: 0.0, inch: 0.0)
    
    // Array
    var distanceArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allocateDelegate()
        distanceArray.append(contentsOf: loadDefaults("DistanceHistory"))
    }
    // Assign delegates
    func allocateDelegate(){
        metreTextField.delegate = self
        kmTextField.delegate = self
        milesTextField.delegate = self
        cmTextField.delegate = self
        mmTextField.delegate = self
        yardTextField.delegate = self
        inchTextField.delegate = self        
    }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    // Conversion - Distance
    @IBAction func handleTextChange(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            metreTextField.text = ""
            kmTextField.text = ""
            milesTextField.text = ""
            cmTextField.text = ""
            mmTextField.text = ""
            yardTextField.text = ""
            inchTextField.text = ""
            return}
        
        switch DistanceScales(rawValue: sender.tag)! {
        
        case .metre :
            distance.metre = roundDecimal( value: (doubleTextFieldValue))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue / 1000))
            distance.miles = roundDecimal( value:(doubleTextFieldValue / 1609.244))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue * 100))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 1000))
            distance.yard =  roundDecimal( value:(doubleTextFieldValue * 1.094))
            distance.inch = roundDecimal( value:(doubleTextFieldValue * 39.37))
            
            
            kmTextField.text = "\(distance.kilometre)"
            milesTextField.text = "\(distance.miles)"
            cmTextField.text = "\(distance.centimetre)"
            mmTextField.text = "\(distance.milimetre)"
            yardTextField.text = "\(distance.yard)"
            inchTextField.text = "\(distance.inch)"
            
        case .kilometre :
            distance.metre = roundDecimal( value:(doubleTextFieldValue * 1000))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue))
            distance.miles = roundDecimal( value:(doubleTextFieldValue / 1.609))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue * 100000))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 1000000))
            distance.yard = roundDecimal( value:(doubleTextFieldValue * 1093.61))
            distance.inch = roundDecimal( value:(doubleTextFieldValue * 39370.1))
            
            
            metreTextField.text = "\(distance.metre)"
            milesTextField.text = "\(distance.miles)"
            cmTextField.text = "\(distance.centimetre)"
            mmTextField.text = "\(distance.milimetre)"
            yardTextField.text = "\(distance.yard)"
            inchTextField.text = "\(distance.inch)"
        
        case .miles :
            distance.metre = roundDecimal( value:(doubleTextFieldValue * 1609.344))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue * 1.60934))
            distance.miles =  roundDecimal( value:(doubleTextFieldValue))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue * 160934.4))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 1.609e+6))
            distance.yard = roundDecimal( value:(doubleTextFieldValue * 1760))
            distance.inch = roundDecimal( value:(doubleTextFieldValue * 63360))
            
            
            kmTextField.text = "\(distance.kilometre)"
            metreTextField.text = "\(distance.metre)"
            cmTextField.text = "\(distance.centimetre)"
            mmTextField.text = "\(distance.milimetre)"
            yardTextField.text = "\(distance.yard)"
            inchTextField.text = "\(distance.inch)"
            
        case .centimetre :
            distance.metre = roundDecimal( value:(doubleTextFieldValue / 100))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue / 100000))
            distance.miles = roundDecimal( value:(doubleTextFieldValue / 160934.4))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 10))
            distance.yard = roundDecimal( value:(doubleTextFieldValue / 91.44))
            distance.inch = roundDecimal( value:(doubleTextFieldValue / 2.54))
            
            
            kmTextField.text = "\(distance.kilometre)"
            milesTextField.text = "\(distance.miles)"
            metreTextField.text = "\(distance.metre)"
            mmTextField.text = "\(distance.milimetre)"
            yardTextField.text = "\(distance.yard)"
            inchTextField.text = "\(distance.inch)"
            
        case .milimetre :
            distance.metre = roundDecimal( value:(doubleTextFieldValue / 1000))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue / 1e-6))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue / 10))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue))
            distance.yard = roundDecimal( value:(doubleTextFieldValue / 914.4))
            distance.inch = roundDecimal( value:(doubleTextFieldValue / 25.4))
            
            
            kmTextField.text = "\(distance.kilometre)"
            milesTextField.text = "\(distance.miles)"
            cmTextField.text = "\(distance.centimetre)"
            metreTextField.text = "\(distance.metre)"
            yardTextField.text = "\(distance.yard)"
            inchTextField.text = "\(distance.inch)"
            
        case .yard :
            distance.metre = roundDecimal( value:(doubleTextFieldValue / 1.094))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue / 1094))
            distance.miles = roundDecimal( value:(doubleTextFieldValue / 1760))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue * 91.44))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 914.4))
            distance.yard = roundDecimal( value:(doubleTextFieldValue))
            distance.inch = roundDecimal( value:(doubleTextFieldValue * 36))
            
            
            kmTextField.text = "\(distance.kilometre)"
            milesTextField.text = "\(distance.miles)"
            cmTextField.text = "\(distance.centimetre)"
            mmTextField.text = "\(distance.milimetre)"
            metreTextField.text = "\(distance.metre)"
            inchTextField.text = "\(distance.inch)"
            
        case .inch :
            distance.metre = roundDecimal( value:(doubleTextFieldValue / 39.37))
            distance.kilometre = roundDecimal( value:(doubleTextFieldValue / 39370))
            distance.miles = roundDecimal( value:(doubleTextFieldValue / 63360))
            distance.centimetre = roundDecimal( value:(doubleTextFieldValue * 2.54))
            distance.milimetre = roundDecimal( value:(doubleTextFieldValue * 25.4))
            distance.yard = roundDecimal( value:(doubleTextFieldValue / 36))
            distance.inch = roundDecimal( value:(doubleTextFieldValue))
            
            
            kmTextField.text = "\(distance.kilometre)"
            milesTextField.text = "\(distance.miles)"
            cmTextField.text = "\(distance.centimetre)"
            mmTextField.text = "\(distance.milimetre)"
            yardTextField.text = "\(distance.yard)"
            metreTextField.text = "\(distance.metre)"
            
        }
    }
    
    // Rounding Decimal
    func roundDecimal( value: Double) -> Double{
        let deciPower = Double(round((pow(10,Double(RoundDecimal.instance.roundDecimal)))))
        return Double(round(deciPower*value)/deciPower)
        
    }
    
    //User Default
    func loadDefaults(_ speedHistoryKey: String) -> [String] {
        let defaults = UserDefaults.standard
        
        return defaults.object(forKey: speedHistoryKey) as? [String] ?? [String]()
    }
    
    @IBAction func saveDistance(_ sender: UIButton) {
        if metreTextField.text == ""{
            errorAlert()
        }else{
            // User Defaults - Store data
            let defaults = UserDefaults.standard
            let distanceString = distance.getDistance()
            // Limiting the count to 5
            if distanceArray.count >= max_count{
                distanceArray = Array(distanceArray.suffix(max_count-1))
            }
    
            distanceArray.append(distanceString)
            defaults.setValue(distanceArray, forKey: "DistanceHistory")
            successAlert()
            clearField()
        }
    }
    
    // Success Alert
    func successAlert(){
        let alert =  UIAlertController(title: "Success", message: "The Conversion saved successully!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true)
    }
    
    // Error Alert
    func errorAlert(){
        let alert =  UIAlertController(title: "Error", message: "TextFeilds are empty!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true)
        
    }
    
    // Clear TextFields
    func clearField(){
        metreTextField.text = ""
        kmTextField.text = ""
        milesTextField.text = ""
        cmTextField.text = ""
        mmTextField.text = ""
        yardTextField.text = ""
        inchTextField.text = ""
    }
}
