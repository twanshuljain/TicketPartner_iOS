//
//  CustomButton.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var disabledColor: UIColor? = UIColor.black.withAlphaComponent(0.12)
    @IBInspectable var enabledColor: UIColor? = UIColor.orange
    @IBInspectable var disabledTitleColor: UIColor? = UIColor.black.withAlphaComponent(0.38) {
        didSet {
            self.setTitleColor(disabledTitleColor, for: .disabled)
        }
    }
    func changeState(enabled: Bool) {
        isEnabled = enabled
        UIView.performWithoutAnimation {
            if let disabledColor = disabledColor {
                self.backgroundColor = isEnabled ? enabledColor : disabledColor
                self.layoutIfNeeded()
            }
        }
    }
    
}

