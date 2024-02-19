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
        window.removePopOverView
        window.addSubview(self.popOverView)
        self.popOverView.frame = window.bounds
    }
    
    func setUpAction() {
        self.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
    }
    
    func setUpView() {
        self.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.popOverView.lblMsg.text = "Your password has been reset successfully"
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
extension ResetPasswordViewController {
    @IBAction func btnResetAction(_ sender: UIButton) {
        self.popOverView.isHidden = !self.popOverView.isHidden
    }
}
