//
//  OTPView.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class OTPView: UIView {
    
    
    @IBOutlet weak var txtOtp1: UITextField!
    @IBOutlet weak var txtOtp2: UITextField!
    @IBOutlet weak var txtOtp3: UITextField!
    @IBOutlet weak var txtOtp4: UITextField!
    @IBOutlet weak var lblReceiveOtp: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblOTP: UILabel!


    let nibName = "OTPView"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.setFont()
    }
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

// MARK: - FUNCTIONS
extension OTPView {
    func initSetup() {
        self.setFont()
    }
    
    func setFont() {
        self.lblOTP.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtOtp1.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp2.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp3.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp4.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblReceiveOtp.font = CustomFont.shared.regular(sizeOfFont: 14.0)
       // self.btnResend.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14.0)
    }
}
