//
//  ResetPasswordViewController.swift
//  TicketSpark
//
//  Created by Apple on 14/02/24.
//

import UIKit

class ResetPasswordViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    
    // MARK: - VARIABLES
    var viewModel = ResetPasswordViewModel()
    var btnResetEnabled = false {
        didSet {
            if btnResetEnabled {
                self.btnReset.isEnabled = true
                self.btnReset.alpha = 1
            }  else {
                self.btnReset.isEnabled = false
                self.btnReset.alpha = 0.5
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
}

// MARK: - FUNCTIONS
extension ResetPasswordViewController {
    func initSetup() {
        self.setFont()
        self.setUpView()
        self.setUpAction()
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblNewPassword.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.lblConfirmPassword.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtNewPassword.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtConfirmPassword.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.btnReset.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
    }
    
    func addPopOverView() {
        window?.removePopOverView
        window?.addSubview(self.viewModel.popOverView)
        self.viewModel.popOverView.frame = window?.bounds ?? CGRect.zero
    }
    
    func setUpAction() {
        self.viewModel.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        [txtNewPassword, txtConfirmPassword].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    func setUpView() {
        self.viewModel.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.viewModel.popOverView.lblMsg.text = "Your password has been reset successfully"
        self.validateFields()
    }
    
    @objc func popOverViewAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        self.validateFields()
    }
    
    func validateFields() {
        guard
            let newPass = txtNewPassword.text, !newPass.isEmpty,
            let confirmPass = txtConfirmPassword.text, !confirmPass.isEmpty
        else {
            self.btnResetEnabled = false
            return
        }
        self.btnResetEnabled = true
    }
    
    func resetPassword() {
        let isValidate = viewModel.validateFields(self.txtNewPassword.text ?? "", self.txtConfirmPassword.text ?? "")
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.resetPasswordAPI(self.txtNewPassword.text ?? "", self.txtConfirmPassword.text ?? "", resetToken: self.viewModel.resetPasswordRequest?.resetToken ?? "") { isSuccess, data, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                            DispatchQueue.main.async {
                                self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
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
extension ResetPasswordViewController {
    @IBAction func btnResetAction(_ sender: UIButton) {
        self.resetPassword()
    }
}
