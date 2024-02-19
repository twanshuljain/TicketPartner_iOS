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
    let popOverView = PopOverView()
    let window = UIApplication.shared.keyWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        self.hideNavBarImage = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addPopOverView()
        self.popOverView.isHidden = true
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
        self.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.popOverView.lblMsg.text = "Your reset password link has been sent to your registered email address. Please check your email."
    }
    
    func addPopOverView() {
        window.removePopOverView
        window.addSubview(self.popOverView)
        self.popOverView.frame = window.bounds
    }
    
    func setUpAction() {
        self.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        self.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
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
        self.popOverView.isHidden = !self.popOverView.isHidden
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
// MARK: - ACTIONS
extension ForgotPasswordViewController{
   
   @IBAction func btnContinueAction(_ sender: UIButton) {
       self.popOverView.isHidden = !self.popOverView.isHidden
       
   }
}
