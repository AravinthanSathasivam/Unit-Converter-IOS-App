//
//  TemperatureViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/14/21.
//

import UIKit

enum TemperatureScales: Int {
    case celsius ,fahrenheit, kelvin
}

private let max_count = 5

class TemperatureViewController: UIViewController , UITextFieldDelegate{
    // Variables
    @IBOutlet weak var keyboardView: CustomKeyboard!
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    
    //creating an object - Temperature
    var temperature : Temperature = Temperature(celsius: 0.0, fahrenheit: 0.0, kelvin: 0.0)
    
    // Array to store Temperature-conversions
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allocateDelegate()
        historyStringArray.append(contentsOf: loadDefaults("TemperatureHistory"))
    }
    // Assign Delegates
    func allocateDelegate(){
        celsiusTextField.delegate = self
        fahrenheitTextField.delegate = self
        kelvinTextField.delegate = self
    }
    // Assign Custom Keyboard to text fields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    // Conversion - Temperature
    @IBAction func handleTextField(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            celsiusTextField.text = ""
            fahrenheitTextField.text = ""
            kelvinTextField.text = ""
            return}
        
        switch TemperatureScales(rawValue: sender.tag)! {
        
        case .celsius:
            temperature.celsius = roundDecimal( value: doubleTextFieldValue)
            temperature.fahrenheit = roundDecimal( value: (doubleTextFieldValue * 9/5 + 32))
            temperature.kelvin = roundDecimal( value: (doubleTextFieldValue + 273.15))
            
            fahrenheitTextField.text = "\(temperature.fahrenheit)"
            kelvinTextField.text = "\(temperature.kelvin)"
        
        case .fahrenheit:
            temperature.celsius = roundDecimal( value: ((doubleTextFieldValue - 32) * 5/9))
            temperature.fahrenheit = roundDecimal( value: (doubleTextFieldValue))
            temperature.kelvin = roundDecimal( value:((doubleTextFieldValue - 32) * 5/9 + 273.15))
            
            celsiusTextField.text = "\(temperature.celsius)"
            kelvinTextField.text = "\(temperature.kelvin)"
        
        case .kelvin:
            temperature.celsius = roundDecimal( value:(doubleTextFieldValue - 273.15))
            temperature.fahrenheit = roundDecimal( value:((doubleTextFieldValue - 273.15 ) * 9/5 + 32))
            temperature.kelvin = roundDecimal( value:(doubleTextFieldValue))
            
            celsiusTextField.text = "\(temperature.celsius)"
            fahrenheitTextField.text = "\(temperature.fahrenheit)"
            
        }
    }
 
    func loadDefaults(_ historyKey: String) -> [String] {
        let defaults = UserDefaults.standard
        
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    // Storing values in User Defaults
    @IBAction func saveTemperature(_ sender: UIButton) {
        if celsiusTextField.text == ""{
            errorAlert()
        }else{
            
            let defaults = UserDefaults.standard
            let historyString = temperature.getTemperature()
            // Limiting the count to 5
            if historyStringArray.count >= max_count{
                historyStringArray = Array(historyStringArray.suffix(max_count-1))
            }
            // Storing data to array
            historyStringArray.append(historyString)
            defaults.setValue(historyStringArray, forKey: "TemperatureHistory")            
            successAlert()
            clearField()
        }
    }
    
    // Rounding Decimal
    func roundDecimal( value: Double) -> Double{
        let deciPower = Double(round((pow(10,Double(RoundDecimal.instance.roundDecimal)))))
        return Double(round(deciPower*value)/deciPower)
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
        celsiusTextField.text = ""
        fahrenheitTextField.text = ""
        kelvinTextField.text = ""
    }
}


