//
//  SplashViewController.swift
//  TicketSpark
//
//  Created by Apple on 14/02/24.
//

import UIKit

class SplashViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle1: UILabel!
    @IBOutlet weak var lblSubTitle2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
    }

}

// MARK: - FUNCTIONS
extension SplashViewController{
    func initSetup() {
        self.hideBackButton = true
        self.setFont()
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblSubTitle1.font = CustomFont.shared.semiBold(sizeOfFont: 30.0)
        self.lblSubTitle2.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        
    }
}
// MARK: - ACTIONS
extension SplashViewController{
   @IBAction func btnContinueAction(_ sender: UIButton) {
       let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
       let navigationVC = UINavigationController(rootViewController: loginVC)
       UIApplication.shared.keyWindow?.rootViewController = navigationVC
   }
}
