//
//  CustomTextFieldView.swift
//  TicketSpark
//
//  Created by Apple on 12/02/24.
//

import UIKit
class CustomTextFieldView: UIView {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var txtFld: UITextField!
    
    let nibName = "CustomTextFieldView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        let view = Self.loadFromXib(withOwner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        self.layer.masksToBounds = true
         txtFld.setTextFiledBorder()
    }
}
