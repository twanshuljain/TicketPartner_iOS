//
//  NextButton.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class NextButton: UIView {
    @IBOutlet weak private var btnSubmit: CustomButton!

    var actionSubmit: ( (UIButton) -> Void )?
    
    @IBInspectable var isEnabled: Bool {
        get {
            return btnSubmit.isEnabled
        }
        set {
            btnSubmit.changeState(enabled: newValue)
        }
    }
    
    var title: String? {
        get {
            return self.btnSubmit.title(for: .normal)
        }
        set {
            self.btnSubmit.setTitle(newValue, for: .normal)
        }
    }
    
    func updateBackgroundColor(color: UIColor = UIColor.orange) {
        btnSubmit.enabledColor = color
        btnSubmit.backgroundColor = color
    }
    
    @IBAction func actionSubmit(_ sender: UIButton) {
        actionSubmit?(sender)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    private func setupFromNib() {
        let view = Self.loadFromXib(withOwner: self, options: nil)
        view.frame = self.bounds
        updateBackgroundColor()
        addSubview(view)
    }

}
