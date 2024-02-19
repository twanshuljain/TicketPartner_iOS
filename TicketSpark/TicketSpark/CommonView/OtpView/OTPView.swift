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
    
    var countdownTimer: Timer!
    var totalTime = 240
    
    var endTimeCallBack : (() -> Void)?
    var otpVerifyCallBack : (() -> Void)?
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
        self.setDelegate()
    }
    
    func setFont() {
        self.lblOTP.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtOtp1.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp2.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp3.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtOtp4.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblReceiveOtp.font = CustomFont.shared.regular(sizeOfFont: 14.0)
        self.btnResend.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 12.0)
    }
    
    func setDelegate() {
        txtOtp1.delegate = self
        txtOtp2.delegate = self
        txtOtp3.delegate = self
        txtOtp4.delegate = self
    }
}

extension OTPView {
    func startTimer() {
        self.totalTime = 240
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTime() {
        self.btnResend.isHidden = true
        lblReceiveOtp.isHidden = false
        lblReceiveOtp.text = "You will receive OTP in \(timeFormatted(self.totalTime))s"
        
        if self.totalTime != 0 {
            self.totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        //self.number = "\(objAppShareData.dicToHoldDataOnSignUpModule?.strDialCountryCode ?? "+91")\(objAppShareData.dicToHoldDataOnSignUpModule?.strNumber ?? "7898525961")"
        //self.vwResend.isHidden = false
        self.countdownTimer.invalidate()
        self.btnResend.isHidden = false
        lblReceiveOtp.isHidden = true
        endTimeCallBack?()
        //btnContinue.isEnabled = false
        //btnContinue.alpha = 0.5
    }
}
// MARK: - UITEXTFIELDDELEGATE
extension OTPView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            if (textField.text!.count < 1) && (string.count > 0) {
                if textField == txtOtp1 {
                    txtOtp2.becomeFirstResponder()
                }
                if textField == txtOtp2 {
                    txtOtp3.becomeFirstResponder()
                }
                if textField == txtOtp3 {
                    txtOtp4.becomeFirstResponder()
                }
                if textField == txtOtp4 {
                    txtOtp4.becomeFirstResponder()
                }

                textField.text = string
                self.otpVerifyCallBack?()
                return false

            } else if (textField.text!.count >= 1) && (string.count == 0) {
                if textField == txtOtp2 {
                    txtOtp1.becomeFirstResponder()
                }
                if textField == txtOtp3 {
                    txtOtp2.becomeFirstResponder()
                }
                if textField == txtOtp4 {
                    txtOtp3.becomeFirstResponder()
                }
                if textField == txtOtp1 {
                    txtOtp1.resignFirstResponder()
                }
                
                textField.text = ""
                return false
            }
            return false
        }
}
