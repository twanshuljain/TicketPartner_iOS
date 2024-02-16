//
//  String+Extension.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
import UIKit
extension String {
    func addAttributedString(highlightedString: String, highlightedColor: UIColor? = .red) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: highlightedString)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightedColor, range: range)
            return attributedString
    }
}
