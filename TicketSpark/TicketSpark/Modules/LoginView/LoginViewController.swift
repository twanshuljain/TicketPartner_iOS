//
//  LoginViewController.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    
    
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
    }
    @IBAction func mobileButtonAction(_ sender: UIButton) {
        emailView.isHidden = !emailView.isHidden
        mobileView.isHidden = !mobileView.isHidden
        
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
    }
}
