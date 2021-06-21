//
//  WeightViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

enum WeightScales: Int {
    case kg ,gram, ounce, pound, stone, s_pound
}

private let max_count = 5

class WeightViewController: UIViewController , UITextFieldDelegate{
    // variable - Custom-Keyboard
    @IBOutlet weak var keyboardView: CustomKeyboard!
    // variables - textfield
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var stoneTextField: UITextField!
    @IBOutlet weak var sPoundTextField: UITextField!
    @IBOutlet weak var kgTextField: UITextField!
    
    
    //creating an object - Weight
    var weight : Weight = Weight(kg: 0.0, gram: 0.0, ounce: 0.0, pound: 0.0, stone: 0.0, s_pound: 0.0)
    
    // Array to store Data- Weights
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allocateDelegate()
    }
    // Assign Delegates
    func allocateDelegate(){
        ounceTextField.delegate = self
        poundTextField.delegate = self
        gramTextField.delegate = self
        stoneTextField.delegate = self
        sPoundTextField.delegate = self
        kgTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    
    // Conversion - Weight
    @IBAction func handleTextField(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            ounceTextField.text = ""
            poundTextField.text = ""
            gramTextField.text = ""
            stoneTextField.text = ""
            sPoundTextField.text = ""
            kgTextField.text = ""
            return}
        
        switch WeightScales(rawValue: sender.tag)! {
        
        case .ounce:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue))
            weight.kg = roundDecimal( value:(doubleTextFieldValue / 35.274))
            weight.gram = roundDecimal( value:(doubleTextFieldValue * 28.35))
            weight.pound = roundDecimal( value:(doubleTextFieldValue / 16))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue / 16))
            weight.stone = roundDecimal( value:(doubleTextFieldValue / 224))
            
            kgTextField.text = "\(weight.kg)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            sPoundTextField.text = "\(weight.s_pound)"
            
        case .pound:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue * 16))
            weight.kg = roundDecimal( value:(doubleTextFieldValue / 2.205))
            weight.gram = roundDecimal( value:(doubleTextFieldValue * 453.592))
            weight.pound = roundDecimal( value:(doubleTextFieldValue))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue))
            weight.stone = roundDecimal( value:(doubleTextFieldValue / 14))
            
            kgTextField.text = "\(weight.kg)"
            ounceTextField.text = "\(weight.ounce)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            sPoundTextField.text = "\(weight.s_pound)"
        
        case .gram:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue / 28.35))
            weight.kg = roundDecimal( value:(doubleTextFieldValue / 1000))
            weight.gram = roundDecimal( value:(doubleTextFieldValue))
            weight.pound = roundDecimal( value:(doubleTextFieldValue / 453.592))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue / 453.592))
            weight.stone = roundDecimal( value:(doubleTextFieldValue / 6350.293))
            
            kgTextField.text = "\(weight.kg)"
            poundTextField.text = "\(weight.pound)"
            ounceTextField.text = "\(weight.ounce)"
            stoneTextField.text = "\(weight.stone)"
            sPoundTextField.text = "\(weight.s_pound)"
            
        case .stone:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue * 224))
            weight.kg = roundDecimal( value:(doubleTextFieldValue * 6.35))
            weight.gram = roundDecimal( value:(doubleTextFieldValue * 6350.293))
            weight.pound = roundDecimal( value:(doubleTextFieldValue * 14))
            weight.stone = roundDecimal( value:(doubleTextFieldValue))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue * 14))
            
            kgTextField.text = "\(weight.kg)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            ounceTextField.text = "\(weight.ounce)"
            sPoundTextField.text = "\(weight.s_pound)"
        
        case .s_pound:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue * 16))
            weight.kg = roundDecimal( value:(doubleTextFieldValue / 2.205))
            weight.gram = roundDecimal( value:(doubleTextFieldValue * 453.592))
            weight.pound = roundDecimal( value:(doubleTextFieldValue))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue))
            weight.stone = roundDecimal( value:(doubleTextFieldValue / 14))
            
            kgTextField.text = "\(weight.kg)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            ounceTextField.text = "\(weight.ounce)"
            
        case .kg:
            weight.ounce = roundDecimal( value:(doubleTextFieldValue * 35.274))
            weight.kg = roundDecimal( value:(doubleTextFieldValue))
            weight.gram = roundDecimal( value:(doubleTextFieldValue * 1000))
            weight.pound = roundDecimal( value:(doubleTextFieldValue * 2.20462))
            weight.stone = roundDecimal( value:(doubleTextFieldValue / 6.350))
            weight.s_pound = roundDecimal( value:(doubleTextFieldValue * 2.20462))
            
            ounceTextField.text = "\(weight.ounce)"
            poundTextField.text = "\(weight.pound)"
            gramTextField.text = "\(weight.gram)"
            stoneTextField.text = "\(weight.stone)"
            sPoundTextField.text = "\(weight.s_pound)"
        }
    }
    
    // Rounding Decimal
    func roundDecimal( value: Double) -> Double{
        let deciPower = Double(round((pow(10,Double(RoundDecimal.instance.roundDecimal)))))
        return Double(round(deciPower*value)/deciPower)
    }
    
    //User Default
    func loadDefaults(_ weightHistoryKey: String) -> [String] {
        let defaults = UserDefaults.standard
        
        return defaults.object(forKey: weightHistoryKey) as? [String] ?? [String]()
    }
    
    @IBAction func saveWeight(_ sender: UIButton) {
        if ounceTextField.text == ""{
            errorAlert()
        }else{
            
            let defaults = UserDefaults.standard
            let historyString = weight.getWeight()
            // Limiting the count to 5
            if historyStringArray.count >= max_count{
                historyStringArray = Array(historyStringArray.suffix(max_count-1))
            }
            historyStringArray.append(historyString)
            defaults.setValue(historyStringArray, forKey: "weightHistory")
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
        ounceTextField.text = ""
        poundTextField.text = ""
        gramTextField.text = ""
        stoneTextField.text = ""
        sPoundTextField.text = ""
        kgTextField.text = ""
    }
}
