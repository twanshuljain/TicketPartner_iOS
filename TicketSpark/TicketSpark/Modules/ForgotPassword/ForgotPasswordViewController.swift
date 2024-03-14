//
//  ForgotPasswordViewController.swift
//  TicketSpark
//
//  Created by Apple on 14/02/24.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
   // @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var btnEmailSendOTP: UIButton!
    
    // MARK: - VARIABLES
    let viewModel = ForgotPasswordViewModel()
    var btnContinueEnabled = false {
        didSet {
            if btnContinueEnabled {
                self.btnContinue.isEnabled = true
                self.btnContinue.alpha = 1
                self.btnContinue.setTitle(StringConstants.ForgotPassword.reset.value, for: .normal)
            }  else {
                self.btnContinue.isEnabled = false
                self.btnContinue.alpha = 0.5
                self.btnContinue.setTitle(StringConstants.ForgotPassword.continueTitle.value, for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        self.hideNavBarImage = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addPopOverView()
        self.viewModel.popOverView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resetView()
    }
}
// MARK: - FUNCTIONS
extension ForgotPasswordViewController {
    func initSetup() {
        self.setFont()
        self.setUpView()
        self.setUpAction()
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmail.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtEmail.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.btnContinue.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        self.btnSignIn.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14.0)
    }
    
    func resetView() {
        self.lblEmail.text = ""
        self.txtEmail.text = ""
        //self.resetOTPView()
    }
    
    func setUpView() {
        self.viewModel.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.viewModel.popOverView.lblMsg.text = StringConstants.ForgotPassword.sendLinkSuccess.value
        self.validateFields()
    }
    
    func addPopOverView() {
        window?.removePopOverView
        window?.addSubview(self.viewModel.popOverView)
        self.viewModel.popOverView.frame = window?.bounds ?? .zero
    }
    
    func setUpAction() {
        self.viewModel.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        self.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
        
        self.txtEmail.addTarget(self,action: #selector(textFieldChangedValue(_:)), for: .editingChanged)
        [txtEmail].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
       // self.setupOTPAction()
    }
    
//    func setupOTPAction() {
//    self.btnEmailSendOTP.isEnabled = false
//    self.btnEmailSendOTP.alpha = 0.5
//        [otpView.txtOtp1, otpView.txtOtp2, otpView.txtOtp3, otpView.txtOtp4].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
//        self.otpView.btnResend.addTarget(self,action:#selector(resendOTPAction), for:.touchUpInside)
//        self.otpView.otpVerifyCallBack = {
//            let otp = "\(self.otpView.txtOtp1.text ?? "")" + "\(self.otpView.txtOtp2.text ?? "")" + "\(self.otpView.txtOtp3.text ?? "")" + "\(self.otpView.txtOtp4.text ?? "")"
//            if self.otpView.txtOtp1.text ?? "" != "" && self.otpView.txtOtp2.text ?? "" != "" && self.otpView.txtOtp3.text ?? "" != "" && self.otpView.txtOtp4.text ?? "" != "" {
//                self.viewModel.otp = otp
//            } else {
//                self.viewModel.otp = ""
//            }
//            self.validateFields()
//        }
//    }
    
    //    func resetOTPView() {
    //        self.otpView.resetField()
    //        if self.otpView.countdownTimer != nil {
    //            self.otpView.endTimer()
    //        }
    //    }
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func textFieldChangedValue(_ sender: UITextField) {
//        self.btnEmailSendOTP.isEnabled = sender.text!.count >= 1
//        self.btnEmailSendOTP.alpha = (sender.text!.count >= 1) ? 1 : 0.5
    }
    
    @objc func popOverViewAction() {
       self.navigateToNextScreen()
    }
    
    func navigateToNextScreen() {
        // FOR OTP FLOW
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
//        vc.viewModel.resetPasswordRequest = self.viewModel.resetPasswordRequest
//        self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
//        self.navigationController?.pushViewController(vc, animated: false)
        
        
        // FOR SEND LINK FLOW
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        var str = textField.text ?? ""
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        if str.contains(" ") {
            textField.text = str.replacingOccurrences(of: " ", with: "")
            return
        }
        self.validateFields()
    }
    
    func validateFields() {
        guard
            let email = txtEmail.text, !email.isEmpty
            //!self.viewModel.otp.isEmpty
        else {
            self.btnContinueEnabled = false
            return
        }
        self.btnContinueEnabled = true
    }
    
    func sendLink() {
        let isValidate = viewModel.validateFields(self.txtEmail.text ?? "")
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.sendForgotPasswordLinkAPI(self.txtEmail.text ?? "") { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        //FOR OTP FLOW
                        //                        if var response = response {
                        //                            DispatchQueue.main.async {
                        //                                self.viewModel.resetPasswordRequest = ResetPasswordRequest(newPassword: "", confirmPassword: "", resetToken: response.resetToken)
                        //                                self.showToast(with: msg ?? "", position: .top, type: .success)
                        //                                self.otpView.validateOTP(valid: true)
                        //                                self.navigateToNextScreen()
                        //                                //self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
                        //                            }
                        //                       }
                        //FOR SEND LINK FLOW
                        DispatchQueue.main.async {
                            self.viewModel.popOverView.isHidden = false
                        }
                    } else {
                        DispatchQueue.main.async {
//                            self.otpView.validateOTP(valid: false)
//                            self.otpView.inValidateOTP()
//                            self.otpView.endTimerForInvalidOTP()
                            self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                        }
                    }
                }
            } else {
                self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
            }
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
            }
        }
    }
    
    @objc func resendOTPAction() {
        self.sendOTP()
    }
    
    func sendOTP() {
        let isValidate = viewModel.validateFields(self.txtEmail.text ?? "")
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.sendOTP(self.txtEmail.text ?? "") { isSuccess, data, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        DispatchQueue.main.async {
                           // self.otpView.startTimer()
                            self.showToast(with: msg ?? "", position: .top, type: .success)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                        }
                    }
                }
            } else {
                self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
            }
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
            }
        }
    }
}
// MARK: - ACTIONS
extension ForgotPasswordViewController{
   
   @IBAction func btnContinueAction(_ sender: UIButton) {
       self.sendLink()
   }
    
    @IBAction func btnSendOTPAction(_ sender: UIButton) {
        self.sendOTP()
    }
}
