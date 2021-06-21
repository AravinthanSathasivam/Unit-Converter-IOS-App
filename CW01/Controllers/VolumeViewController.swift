//
//  VolumeViewController.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

enum VolumeScales: Int {
    case ukGallon ,ukPint, f_ounce, litre, mililitre
}

private let max_count = 5

class VolumeViewController: UIViewController , UITextFieldDelegate{
    
    //create variables
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    @IBOutlet weak var ukGallonTF: UITextField!
    @IBOutlet weak var ukPintTF: UITextField!
    @IBOutlet weak var f_OunceTF: UITextField!
    @IBOutlet weak var litreTF: UITextField!
    @IBOutlet weak var miliLitreTF: UITextField!
    
    //creating an object - Volume
    var volume : Volume = Volume(ukGallon: 0.0, ukPint: 0.0, f_ounce: 0.0, litre: 0.0, stone: 0.0, mililitre: 0.0)
    
    var volumeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allocateDelegate()
        volumeArray.append(contentsOf: loadDefaults("VolumeHistory"))
    }
    // Assign Delegate
    func allocateDelegate(){
        ukGallonTF.delegate = self
        ukPintTF.delegate = self
        f_OunceTF.delegate = self
        litreTF.delegate = self
        miliLitreTF.delegate = self
    }
    
    // Assign Custom Keyboard to text fields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
        textField.inputView = UIView()
    }
    // Conversion - Volume
    @IBAction func handleText(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else {
            ukGallonTF.text = ""
            ukPintTF.text = ""
            f_OunceTF.text = ""
            litreTF.text = ""
            miliLitreTF.text = ""
            return}
        
        switch VolumeScales(rawValue: sender.tag)! {
        
        case .ukGallon:
            volume.ukGallon = roundDecimal( value: doubleTextFieldValue)
            volume.ukPint = roundDecimal( value: (doubleTextFieldValue * 8))
            volume.f_ounce = roundDecimal( value:(doubleTextFieldValue * 160))
            volume.litre = roundDecimal( value: (doubleTextFieldValue * 4.546))
            volume.mililitre = roundDecimal( value: (doubleTextFieldValue * 4546.09))
            
            ukPintTF.text = "\(volume.ukPint)"
            f_OunceTF.text = "\(volume.f_ounce)"
            litreTF.text = "\(volume.litre)"
            miliLitreTF.text = "\(volume.mililitre)"
            
        case .ukPint:
            volume.ukGallon = roundDecimal( value: (doubleTextFieldValue / 8))
            volume.ukPint = roundDecimal( value: (doubleTextFieldValue))
            volume.f_ounce = roundDecimal( value:(doubleTextFieldValue * 20))
            volume.litre = roundDecimal( value:(doubleTextFieldValue / 1.76))
            volume.mililitre = roundDecimal( value: (doubleTextFieldValue * 568.261))
            
            ukGallonTF.text = "\(volume.ukGallon)"
            f_OunceTF.text = "\(volume.f_ounce)"
            litreTF.text = "\(volume.litre)"
            miliLitreTF.text = "\(volume.mililitre)"
            
        case .f_ounce:
            volume.ukGallon = roundDecimal( value:(doubleTextFieldValue / 160))
            volume.ukPint = roundDecimal( value:(doubleTextFieldValue / 20))
            volume.f_ounce = roundDecimal( value: (doubleTextFieldValue))
            volume.litre = roundDecimal( value:(doubleTextFieldValue / 35.195))
            volume.mililitre = (roundDecimal( value:doubleTextFieldValue * 28.413))
            
            ukPintTF.text = "\(volume.ukPint)"
            ukGallonTF.text = "\(volume.ukGallon)"
            litreTF.text = "\(volume.litre)"
            miliLitreTF.text = "\(volume.mililitre)"
            
        case .litre:
            volume.ukGallon = roundDecimal( value:(doubleTextFieldValue / 3.785))
            volume.ukPint = roundDecimal( value:(doubleTextFieldValue * 1.76))
            volume.f_ounce = roundDecimal( value:(doubleTextFieldValue * 35.195))
            volume.litre = roundDecimal( value:(doubleTextFieldValue))
            volume.mililitre = roundDecimal( value:(doubleTextFieldValue * 1000))
            
            ukPintTF.text = "\(volume.ukPint)"
            f_OunceTF.text = "\(volume.f_ounce)"
            ukGallonTF.text = "\(volume.ukGallon)"
            miliLitreTF.text = "\(volume.mililitre)"
            
        case .mililitre:
            volume.ukGallon = roundDecimal( value:(doubleTextFieldValue / 3785.412))
            volume.ukPint = roundDecimal( value:(doubleTextFieldValue / 568.261))
            volume.f_ounce = roundDecimal( value:(doubleTextFieldValue / 28.413))
            volume.litre = roundDecimal( value:(doubleTextFieldValue / 1000))
            volume.mililitre = roundDecimal( value:(doubleTextFieldValue))
            
            ukPintTF.text = "\(volume.ukPint)"
            f_OunceTF.text = "\(volume.f_ounce)"
            litreTF.text = "\(volume.litre)"
            ukGallonTF.text = "\(volume.ukGallon)"
            
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
    
    @IBAction func saveVolume(_ sender: UIButton) {
        if ukGallonTF.text == ""{
            errorAlert()
        }else{
            
            let defaults = UserDefaults.standard
            let historyString = volume.getVolume()
            // Limiting the count to 5
            if volumeArray.count >= max_count{
                volumeArray = Array(volumeArray.suffix(max_count-1))
            }
            
            volumeArray.append(historyString)
            defaults.setValue(volumeArray, forKey: "VolumeHistory")
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
        ukGallonTF.text = ""
        ukPintTF.text = ""
        f_OunceTF.text = ""
        litreTF.text = ""
        miliLitreTF.text = ""
    }
}
