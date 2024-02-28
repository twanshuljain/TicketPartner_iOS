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
    var placeholder: String = "" {
        didSet {
            txtFld.placeholder = placeholder
        }
    }
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
          addPadding()
          setUI()
          self.setFont()
        
    }
    func setUI() {
        txtFld.setTextFiledBorder()
        lbl.textColor = .appBlackTextColor
        lbl.font = CustomFont.shared.medium(sizeOfFont: 14)
        txtFld.font = CustomFont.shared.regular(sizeOfFont: 14)
        txtFld.textColor = .appBlackTextColor
    }
    
    func setFont() {
        self.lbl.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.txtFld.font = CustomFont.shared.regular(sizeOfFont: 16.0)
    }
    
    private func addPadding() {
       let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        txtFld.leftView = paddingView
        txtFld.leftViewMode = .always
    }
}
