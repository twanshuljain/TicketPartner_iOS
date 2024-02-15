//
//  UIWindow+Extension.swift
//  TicketSpark
//
//  Created by Apple on 14/02/24.
//

import UIKit

extension UIWindow {
    var removePopOverView: Void {
        for subview in self.subviews {
            if subview is PopOverView {
                subview.isHidden = true// you can hide the view using this
                subview.removeFromSuperview()// here you are removing the view.
            }
        }
    }
}
