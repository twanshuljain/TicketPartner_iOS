//
//  CreateAccountViewController.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class CreateAccountViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnEmailVerify: UIButton!
    @IBOutlet weak var otpEmailView: OTPView!
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnMobileVerify: UIButton!
    
    @IBOutlet weak var otpMobileView: OTPView!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
   // @IBOutlet weak var popOverView: PopOverView!
    
    // MARK: - VARIABLES
    let popOverView = PopOverView()
    let window = UIApplication.shared.keyWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addPopOverView()
        self.popOverView.isHidden = true
    }

}
// MARK: - FUNCTIONS
extension CreateAccountViewController {
    func initSetup() {
        self.setUpView()
        self.setFont()
        self.setUpAction()
        self.setText()
    }
    
    func addPopOverView() {
        window.removePopOverView
        window.addSubview(self.popOverView)
        self.popOverView.frame = window.bounds
    }
    
    func setText() {
        self.gogleSignInView.lblSeperator.text = "Or Sign up with"
        self.gogleSignInView.lblDontHaveAccount.text = "Already have an account?"
        self.gogleSignInView.btnSignIn.setTitle("Sign in", for: .normal)
    }
    
    func setUpView() {
        self.otpEmailView.isHidden = !self.otpEmailView.isHidden
        self.otpMobileView.isHidden = !self.otpMobileView.isHidden
        self.hideBackButton = true
        self.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.popOverView.lblMsg.text = "Congratulations! Your account has been created successfully."
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmail.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtEmail.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnEmailVerify.titleLabel?.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        
        
        self.lblFirstName.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtFirstName.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.lblLastName.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtLastName.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        
        self.txtMobileNumber.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnMobileVerify.titleLabel?.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        
        self.lblPassword.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtPassword.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnCreateAccount.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
    }
    
    func setUpAction() {
        self.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        self.gogleSignInView.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
    }
    
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func popOverViewAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.popOverView.isHidden = !self.popOverView.isHidden
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
}

// MARK: - ACTIONS
extension CreateAccountViewController {
    
    @IBAction func btnEmailVerifyAction(_ sender : UIButton) {
        self.otpEmailView.isHidden = !self.otpEmailView.isHidden
    }
    
    @IBAction func btnMobileVerifyAction(_ sender : UIButton) {
        self.otpMobileView.isHidden = !self.otpMobileView.isHidden
    }
    
    @IBAction func btnCreateAccount(_ sender : UIButton) {
        self.popOverView.isHidden = !self.popOverView.isHidden
    }
    
}
