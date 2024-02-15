//
//  PopOverView.swift
//  TicketSpark
//
//  Created by Apple on 14/02/24.
//

import UIKit

class PopOverView: UIView {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var btnPop: UIButton!
    
    let nibName = "PopOverView"
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
// MARK: - FUNCTIONS
extension PopOverView {
    func initSetup() {
        self.setFont()
    }
    
    func setFont() {
        self.lblMsg.font = CustomFont.shared.regular(sizeOfFont: 12.0)
    }
}
