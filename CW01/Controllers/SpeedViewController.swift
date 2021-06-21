//
//  SpeedViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/16/21.
//

import UIKit

enum SpeedScales: Int {
    case metre_Sec ,kilometre_Hour, miles_Hour ,knot
}

private let max_count = 5

class SpeedViewController: UIViewController, UITextFieldDelegate {
    // Custom-Keyboard - varaibles
    @IBOutlet weak var keyboardView: CustomKeyboard!
    // TextField - variables
    @IBOutlet weak var metre_SecTextField: UITextField!
    @IBOutlet weak var km_HourTextField: UITextField!
    @IBOutlet weak var miles_HourTextField: UITextField!
    @IBOutlet weak var knotTextField: UITextField!
    
    //creating an object - Speed
    var speed : Speed = Speed(metre_Sec: 0.0, kilometre_Hour: 0.0, miles_Hour: 0.0, knot: 0.0)
    
    // Array to store Temperature-conversions
    var speedArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allocateDelegate()
        speedArray.append(contentsOf: loadDefaults("SpeedHistory"))
    }
    //Assign Delegates
    func allocateDelegate(){
        metre_SecTextField.delegate = self
        km_HourTextField.delegate = self
        miles_HourTextField.delegate = self
        knotTextField.delegate = self

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    // Conversion - Distance
    @IBAction func handleTextField(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            metre_SecTextField.text = ""
            km_HourTextField.text = ""
            miles_HourTextField.text = ""
            knotTextField.text = ""
            return}
        
        switch SpeedScales(rawValue: sender.tag)! {
        
        case .metre_Sec:
            speed.metre_Sec = roundDecimal( value:(doubleTextFieldValue))
            speed.kilometre_Hour = roundDecimal( value:(doubleTextFieldValue * 3.6))
            speed.miles_Hour = roundDecimal( value:(doubleTextFieldValue * 2.237))
            speed.knot = roundDecimal( value:(doubleTextFieldValue * 1.944))
            
            km_HourTextField.text = "\(speed.kilometre_Hour)"
            miles_HourTextField.text = "\(speed.miles_Hour)"
            knotTextField.text = "\(speed.knot)"
            
        case .kilometre_Hour:
            speed.metre_Sec = roundDecimal( value:(doubleTextFieldValue * 0.278))
            speed.kilometre_Hour = roundDecimal( value:(doubleTextFieldValue))
            speed.miles_Hour = roundDecimal( value:(doubleTextFieldValue * 0.621))
            speed.knot = roundDecimal( value:(doubleTextFieldValue * 0.54))
            
            metre_SecTextField.text = "\(speed.metre_Sec)"
            miles_HourTextField.text = "\(speed.miles_Hour)"
            knotTextField.text = "\(speed.knot)"
            
        case .miles_Hour:
            speed.metre_Sec = roundDecimal( value:(doubleTextFieldValue * 0.447))
            speed.kilometre_Hour = roundDecimal( value:(doubleTextFieldValue))
            speed.miles_Hour = roundDecimal( value:(doubleTextFieldValue * 1.609))
            speed.knot = roundDecimal( value:(doubleTextFieldValue * 0.869))
            
            km_HourTextField.text = "\(speed.kilometre_Hour)"
            miles_HourTextField.text = "\(speed.miles_Hour)"
            knotTextField.text = "\(speed.knot)"
            
        case .knot:
            speed.metre_Sec = roundDecimal( value:(doubleTextFieldValue * 0.514))
            speed.kilometre_Hour = roundDecimal( value:(doubleTextFieldValue * 1.852))
            speed.miles_Hour = roundDecimal( value:(doubleTextFieldValue * 1.151))
            speed.knot = roundDecimal( value:(doubleTextFieldValue))
            
            metre_SecTextField.text = "\(speed.metre_Sec)"
            km_HourTextField.text = "\(speed.kilometre_Hour)"
            miles_HourTextField.text = "\(speed.miles_Hour)"
            
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
    
    // Save Speed Conversion
    @IBAction func saveSpeed(_ sender: UIButton) {
        if metre_SecTextField.text == ""{
            errorAlert()
        }else{
            // User Defaults - Store data
            let defaults = UserDefaults.standard
            let speedString = speed.getSpeed()
            // Limiting the count to 5
            if speedArray.count >= max_count{
                speedArray = Array(speedArray.suffix(max_count-1))
            }
    
            speedArray.append(speedString)
            defaults.setValue(speedArray, forKey: "SpeedHistory")
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
        metre_SecTextField.text = ""
        km_HourTextField.text = ""
        miles_HourTextField.text = ""
        knotTextField.text = ""
    }
}
