//
//  SignUpViewController.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblSignUpTitle: UILabel!
    @IBOutlet weak var lblSignUpSubTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPolicy: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
    
    // MARK: - VARIABLES
    let viewModel = SignUpViewModel()
    var signUpButtonEnabled = false {
        didSet {
            if signUpButtonEnabled {
                self.btnSignUp.isEnabled = true
                self.btnSignUp.alpha = 1
            }  else {
                self.btnSignUp.isEnabled = false
                self.btnSignUp.alpha = 0.5
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        self.hideNavBarImage = false
    }

}
// MARK: - FUNCTIONS
extension SignUpViewController {
    func initSetup() {
        self.setFont()
        self.setText()
        self.setUpAction()
        self.setUpView()
        
    }
    
    func setText() {
        self.gogleSignInView.lblSeperator.text = "Or Sign up with"
        self.gogleSignInView.lblDontHaveAccount.text = "Already have an account?"
        self.gogleSignInView.btnSignIn.setTitle("Sign in", for: .normal)
    }
    
    func setUpView() {
        self.hideBackButton = true
        self.validateFields()
    }
    
    func setFont() {
        self.lblSignUpTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSignUpSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmail.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.lblPolicy.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtEmail.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.btnSignUp.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
    }
    
    func setUpAction() {
        self.gogleSignInView.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
        self.txtEmail.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
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
            let email = txtEmail.text, !email.isEmpty
        else {
            self.signUpButtonEnabled = false
            return
        }
        self.signUpButtonEnabled = true
    }
}
// MARK: - ACTIONS
extension SignUpViewController {
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        let isValidate = viewModel.validateFields(self.txtEmail.text ?? "")
        if isValidate.1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
            vc.viewModel.signUpRequest = SignUpRequest(email: self.txtEmail.text ?? "")
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
               //self.showAlert(message: isValidate.0)
            }
        }
    }
}
