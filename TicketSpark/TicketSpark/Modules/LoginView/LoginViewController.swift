//
//  LoginViewController.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgMobileNumber: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setNavigationBar()
    }
    
    func setNavigationBar(){
       // self.hideBackButton = false
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
}
