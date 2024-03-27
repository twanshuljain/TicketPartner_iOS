//
//  UITextField+Extension.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import Foundation
import UIKit
extension UITextField {
    func setInputViewDatePicker(minimumDate: Date?, maximumDate: Date?, target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 215))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        if let minDate = minimumDate {
            datePicker.minimumDate = minDate
        }
        if let maxDate = maximumDate {
            datePicker.maximumDate = maxDate
        }
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: true)
        self.inputAccessoryView = toolBar
    }
    
    func setInputViewTimePicker(minimumDate: Date?, maximumDate: Date?, target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 215))
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        if let minDate = minimumDate {
            datePicker.minimumDate = minDate
        }
//        else {
//            datePicker.minimumDate = Date()
//        }
        
        if let maxDate = maximumDate {
            datePicker.maximumDate = maxDate
        }
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: true)
        self.inputAccessoryView = toolBar
    }
}

extension UITextField {
  var placeholder1: String? {
    get {
      attributedPlaceholder?.string
    }
    set {
      guard let newValue = newValue else {
        attributedPlaceholder = nil
        return
      }
      let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightText.cgColor]
      let attributedText = NSAttributedString(string: newValue, attributes: attributes)
      attributedPlaceholder = attributedText
    }
  }
  enum ViewType {
    case left, right
  }
  @discardableResult
  func setView(_ view: ViewType, space: CGFloat) -> UIView {
    let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: 1))
    setView(view, with: spaceView)
    return spaceView
  }
  func setView(_ type: ViewType, with view: UIView) {
    if type == ViewType.left {
      leftView = view
      leftViewMode = .always
    } else if type == .right {
      rightView = view
      rightViewMode = .always
    }
  }
  @discardableResult
  func setView(_ view: ViewType, title: String, space: CGFloat = 0) -> UIButton {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: frame.height))
    button.setTitle(title, for: UIControl.State())
    button.contentEdgeInsets = UIEdgeInsets(top: 4, left: space, bottom: 4, right: space)
    button.sizeToFit()
    setView(view, with: button)
    return button
  }
  @discardableResult
  func setView(_ view: ViewType, image: UIImage?, width: CGFloat = 50) -> UIButton {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
    button.setImage(image, for: .normal)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left:(image?.size.width)! / 2, bottom: 0, right: 50)
    button.contentHorizontalAlignment = .right
    button.imageView?.contentMode = .scaleAspectFit
    setView(view, with: button)
    return button
  }
  func setPlaceholderColor(_ color: UIColor) {
    guard let placeholder = placeholder else { return }
    let attributes = [NSAttributedString.Key.foregroundColor: color]
    attributedPlaceholder = NSAttributedString(string: placeholder,
                          attributes: attributes)
  }
  func toggleSecure() {
    isSecureTextEntry = !isSecureTextEntry
  }
  func selectAllText() {
    selectedTextRange = textRange(from: beginningOfDocument, to: endOfDocument)
  }
  @IBInspectable var doneAccessory: Bool{
      get{
        return self.doneAccessory
      }
      set (hasDone) {
        if hasDone{
          addDoneButtonOnKeyboard()
        }
      }
    }
    func addDoneButtonOnKeyboard()
    {
      let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
      doneToolbar.barStyle = .default
      let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
      let items = [flexSpace, done]
      doneToolbar.items = items
      doneToolbar.sizeToFit()
      self.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction()
    {
      self.resignFirstResponder()
    }
}
class CustomTextField: UITextField {
    func setup() {
      self.layer.borderColor = UIColor.init(named: "BorderLineColour")?.cgColor
      self.layer.borderWidth = 1
      self.backgroundColor = .white
      self.layer.cornerRadius = 5
      self.setPlaceholderColor(UIColor.init(named: "PlaceHolder")!)
      self.font = CustomFont.shared.regular(sizeOfFont: 15.0)
      //UIFont.setFont(fontType: .regular, fontSize: .fifteen)
   }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
}
