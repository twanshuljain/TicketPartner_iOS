//
//  GoogleSignInView.swift
//  TicketSpark
//
//  Created by Apple on 12/02/24.
//

import UIKit

class GoogleSignInView: UIView {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var lblSeperator: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblDontHaveAccount: UILabel!
    
    let XIB_NAME = "GoogleSignInView"
    
    let nibName = "GoogleSignInView"
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            self.setFont()
        }
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
}

// MARK: - FUNCTIONS
extension GoogleSignInView {
    func initSetup() {
        self.setFont()
    }
    
    func setFont() {
        self.lblSeperator.font = CustomFont.shared.bold(sizeOfFont: 12.0)
        self.lblDontHaveAccount.font = CustomFont.shared.regular(sizeOfFont: 14.0)
        self.btnSignIn.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14.0)
    }
}

// MARK: - ACTIONS
extension GoogleSignInView {
    @IBAction func btnGoogleSignInAction(_ sender: UIButton) {
    }
    
    @IBAction func btnAppleSignInAction(_ sender: UIButton) {
    }
    
    @IBAction func btnSignInAction(_ sender: UIButton) {
    }
}
