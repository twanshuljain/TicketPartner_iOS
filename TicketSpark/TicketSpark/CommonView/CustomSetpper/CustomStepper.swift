//
//  CustomStepper.swift
//  Ticket
//
//  Created by Apple  on 11/05/23.
//

import UIKit



class CustomStepper: UIView {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    let nibName = "CustomStepper"
    var stepperCount: Int = 0 {
        didSet {
            lblCount.text = "\(stepperCount)"
        }
    }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        private func commonInit() {
          
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.lblCount.text = "0"
           self.addSubview(view)
        }
        
        private func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    // MARK: - Actions
    @IBAction func actionPlus(_ sender: UIButton) {
        stepperCount += 1
    }
    
    @IBAction func actionMinus(_ sender: UIButton) {
        if stepperCount > 0 {
            stepperCount -= 1
        } else {
            stepperCount = 0
        }
    }
}
