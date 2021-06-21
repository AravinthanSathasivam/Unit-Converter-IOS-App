//
//  DataViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

enum DataScales: Int {
    case kilobyte ,megabyte, gigabyte, terabyte
}
private let max_count = 5

class DataViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    @IBOutlet weak var kbTextField: UITextField!
    @IBOutlet weak var mbTextField: UITextField!
    @IBOutlet weak var gbTextField: UITextField!
    @IBOutlet weak var tbTextField: UITextField!
    
    
    //creating an object - Data
    var data : Data = Data(kilobyte: 0.0, megabyte: 0.0, gigabyte: 0.0, terabyte: 0.0)
    
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allocateDelegate()
    }
    
    func allocateDelegate(){
        kbTextField.delegate = self
        mbTextField.delegate = self
        gbTextField.delegate = self
        tbTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    
    @IBAction func handleTextEdit(_ sender: UITextField) {
        
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            kbTextField.text = ""
            mbTextField.text = ""
            gbTextField.text = ""
            tbTextField.text = ""
            return}
        
        switch DataScales(rawValue: sender.tag)! {
        
        case .kilobyte:
            data.kilobyte = roundDecimal( value:(doubleTextFieldValue))
            data.megabyte = roundDecimal( value:(doubleTextFieldValue / 1024))
            data.gigabyte = roundDecimal( value:(doubleTextFieldValue / 1048576))
            data.terabyte = roundDecimal( value:(doubleTextFieldValue / 1073741824))
            
            
            mbTextField.text = "\(data.megabyte)"
            gbTextField.text = "\(data.gigabyte)"
            tbTextField.text = "\(data.terabyte)"
            
        case .megabyte:
            data.kilobyte = roundDecimal( value:(doubleTextFieldValue * 1024))
            data.megabyte = roundDecimal( value:(doubleTextFieldValue))
            data.gigabyte = roundDecimal( value:(doubleTextFieldValue / 1024))
            data.terabyte = roundDecimal( value:(doubleTextFieldValue / 1048576))
            
            
            kbTextField.text = "\(data.kilobyte)"
            gbTextField.text = "\(data.gigabyte)"
            tbTextField.text = "\(data.terabyte)"
        
        case .gigabyte:
            data.kilobyte = roundDecimal( value:(doubleTextFieldValue *  1048576))
            data.megabyte = roundDecimal( value:(doubleTextFieldValue * 1024))
            data.gigabyte = roundDecimal( value:(doubleTextFieldValue))
            data.terabyte = roundDecimal( value:(doubleTextFieldValue / 1024))
            
            
            mbTextField.text = "\(data.megabyte)"
            kbTextField.text = "\(data.kilobyte)"
            tbTextField.text = "\(data.terabyte)"
            
        case .terabyte:
            data.kilobyte = roundDecimal( value:(doubleTextFieldValue * 1073741824))
            data.megabyte = roundDecimal( value:(doubleTextFieldValue * 1048576))
            data.gigabyte = roundDecimal( value:(doubleTextFieldValue * 1024))
            data.terabyte = roundDecimal( value:(doubleTextFieldValue))
            
            
            mbTextField.text = "\(data.megabyte)"
            gbTextField.text = "\(data.gigabyte)"
            kbTextField.text = "\(data.kilobyte)"
            
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

    @IBAction func saveData(_ sender: UIButton) {
        if kbTextField.text == ""{
            errorAlert()
        }else{
            
            let defaults = UserDefaults.standard
            let historyString = data.getData()
            // Limiting the count to 5
            if historyStringArray.count >= max_count{
                historyStringArray = Array(historyStringArray.suffix(max_count-1))
            }
            
            historyStringArray.append(historyString)
            defaults.setValue(historyStringArray, forKey: "DataHistory")
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
        kbTextField.text = ""
        mbTextField.text = ""
        gbTextField.text = ""
        tbTextField.text = ""
    }
}
