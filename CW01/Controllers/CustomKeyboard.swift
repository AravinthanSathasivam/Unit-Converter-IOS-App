//
//  CustomKeyboard.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/7/21.
//

import UIKit

enum KeyboardButtons: Int {
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal, delete, negative
}

class CustomKeyboard: UIView {

    var activeTextField = UITextField()
        
    // Assign custom-keyboard nib
        let nibName = "CustomKeyboard"
        var contentView:UIView?
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            contentView = view
        }
        
        func loadViewFromNib() -> UIView? {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    // keyboard button click handling
    @IBAction func handleBtnClick(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text {
            
            switch KeyboardButtons (rawValue: sender.tag) {
            case .decimal:
                if !currentText.contains("."), currentText.count != 0 {
                    activeTextField.insertText(".")
                    setCursorPosition(from: cursorPosition)
                }
            case .delete:
                if currentText.count != 0 {
                    self.activeTextField.text?.remove(at: currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1))
                    
                    if String(currentText[currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1)]) != "." {
                        activeTextField.sendActions(for: UIControl.Event.editingChanged)
                    }
                    setCursorPosition(from: cursorPosition, offset: -1)
                }
            case .negative:
                if !currentText.contains("-"), currentText.count != 0 {
                    activeTextField.text?.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 0))
                    setCursorPosition(from: cursorPosition)
                }
            default:
                activeTextField.insertText(String(sender.tag))
                setCursorPosition(from: cursorPosition)
            }
            
        }
    }
    // Finding the position of the cursor
    func getCursorPosition() -> Int {
        
        guard let selectRange = activeTextField.selectedTextRange else {return 0}
        return activeTextField.offset(from: activeTextField.beginningOfDocument, to: selectRange.start)
        
    }
    
    // setting the cursor position
    func setCursorPosition(from:Int, offset: Int = 1) {
        if let newPosition = activeTextField.position(from: activeTextField.beginningOfDocument, offset: from + offset) {
            activeTextField.selectedTextRange = activeTextField.textRange(from: newPosition, to: newPosition)
        }
    }
    

    

}
