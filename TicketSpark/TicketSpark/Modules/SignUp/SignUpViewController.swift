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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
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
    }
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
}
// MARK: - ACTIONS
extension SignUpViewController {
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
