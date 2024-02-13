//
//  FloatingTextField.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import Foundation
import UIKit

class FloatingTextField: UITextField {
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero) // Label
    var floatingLabelHeight: CGFloat = 14 // Default height
    @IBInspectable
    var _placeholder: String? // we cannot override 'placeholder'
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder // Use our custom placeholder if none is set
        placeholder = self._placeholder // make sure the placeholder is shown
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    @objc func addFloatingLabel() {
        self.setInputViewDatePicker(target: self, selector: #selector(doneTapped))
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
    self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)
          
            self.floatingLabel.bottomAnchor.constraint(equalTo:
            self.topAnchor, constant: 10).isActive = true // Place our label 10pts above the text field
            // Remove the placeholder
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
               self.subviews.forEach{ $0.removeFromSuperview() }
               self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func doneTapped() {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "MM/yyyy"
            self.text = dateFormatter.string(from: datePicker.date)
        }
        self.resignFirstResponder()
    }
}
extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 215))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: true)
        self.inputAccessoryView = toolBar
    }
}
