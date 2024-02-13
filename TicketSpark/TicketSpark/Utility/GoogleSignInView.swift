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
        }
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
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