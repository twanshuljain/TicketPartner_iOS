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
    
    func setUpView() {
        self.viewModel.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.viewModel.popOverView.lblMsg.text = StringConstants.ForgotPassword.sendLinkSuccess.value
        self.validateFields()
    }
    
    func addPopOverView() {
        viewModel.window.removePopOverView
        viewModel.window.addSubview(self.viewModel.popOverView)
        self.viewModel.popOverView.frame = viewModel.window.bounds
    }
    
    func setUpAction() {
        self.viewModel.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        self.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
        self.txtEmail.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func popOverViewAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        vc.viewModel.resetPasswordRequest = self.viewModel.resetPasswordRequest
        self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
        self.navigationController?.pushViewController(vc, animated: false)
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
            let email = txtEmail.text, !email.isEmpty
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
                        if var response = response {
                            DispatchQueue.main.async {
                                self.viewModel.resetPasswordRequest = ResetPasswordRequest(newPassword: "", confirmPassword: "", resetToken: response.resetToken)
                                self.viewModel.popOverView.isHidden = !self.viewModel.popOverView.isHidden
                            }
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
}
