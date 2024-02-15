//
//  LoginViewController.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblSignInTitle: UILabel!
    @IBOutlet weak var lblSignInSubTitle: UILabel!
    @IBOutlet weak var lblEmailView: UILabel!
    @IBOutlet weak var lblMobileView: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgRememberMe: UIImageView!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnJoinAdmissionStaff: UIButton!
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var otpView: OTPView!
    
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgMobileNumber: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
    }
}
// MARK: - FUNCTIONS
extension LoginViewController {
    func initSetup() {
        self.setUpView()
        self.setFont()
        self.setUpAction()
        self.setText()
    }
    
    func setText() {
        self.gogleSignInView.lblSeperator.text = "Or Sign in with"
        self.gogleSignInView.lblDontHaveAccount.text = "Don’t have an account?"
        self.gogleSignInView.btnSignIn.setTitle("Sign up", for: .normal)
    }
    
    func setUpView() {
        self.hideBackButton = true
    }
    
    func setFont() {
        self.lblSignInTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSignInSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmailView.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        self.lblMobileView.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        self.lblEmail.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.lblPassword.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtEmail.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtPassword.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblForgotPassword.font = CustomFont.shared.bold(sizeOfFont: 12.0)
        self.btnSignIn.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 16.0)
        self.btnJoinAdmissionStaff.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        
        self.lblMobileNumber.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtMobileNumber.font = CustomFont.shared.regular(sizeOfFont: 16.0)
    }
    
    func setUpAction() {
        self.gogleSignInView.btnSignIn.addTarget(self,action:#selector(signUpAction), for:.touchUpInside)
    }
    
    
    @objc func signUpAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - ACTIONS
extension LoginViewController {
    @IBAction func emailButtonAction(_ sender: UIButton) {
        emailView.isHidden = !emailView.isHidden
        mobileView.isHidden = !mobileView.isHidden
        self.imgEmail.image = UIImage(named: "imgRadioSelected")
        self.imgMobileNumber.image = UIImage(named: "imgRadioUnselected")
    }
    @IBAction func mobileButtonAction(_ sender: UIButton) {
        emailView.isHidden = !emailView.isHidden
        mobileView.isHidden = !mobileView.isHidden
        self.imgEmail.image = UIImage(named: "imgRadioUnselected")
        self.imgMobileNumber.image = UIImage(named: "imgRadioSelected")
        
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func joinAdmissionStaffAction(_ sender: UIButton) {
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        
    }
}
