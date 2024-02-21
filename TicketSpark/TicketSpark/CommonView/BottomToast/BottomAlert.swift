//
//  CommonAlert.swift
//  Nagad
//
//  Created by Deepak Garg on 01/08/22.
//

import UIKit

class BottomAlert: UIView {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var alertIconImageView: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setupFromNib() {
        let view = Self.loadFromXib(withOwner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
    
    func setProperties(xAxis: CGFloat, yAxis: CGFloat, width: CGFloat, height: CGFloat) {
        self.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
    }
    
    func getTopPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
          if let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.top
          }
        }
        return 20 // status bar height
      }

    func change_Position(toPosition: SelectPosition, text: String, type: AlertType) {
        lblMessage.text = text
        self.lblMessage.textColor = .white
        
        switch type {
        case .success:
            self.backgroundView.backgroundColor = UIColor(hex: "#21BE79")
            //self.alertIconImageView.image = UIImage(named: "ic_pin_success_white")
        case .warning:
            self.backgroundView.backgroundColor = .red
            self.alertIconImageView.image = UIImage(named: ImageConstants.Image.imgError.value)
        case .failure:
            self.backgroundView.backgroundColor = .red
            //self.alertIconImageView.image = UIImage(named: "error_Icon")
        }
        
        switch toPosition {
        case .top:
            self.frame = CGRect(x: 0, y: self.getTopPadding(), width: UIApplication.shared.keyWindow!.frame.size.width, height: 0)
        case .bottom:
            self.frame = CGRect(x: 0, y: UIApplication.shared.keyWindow!.frame.size.height - 50.0, width: UIApplication.shared.keyWindow!.frame.size.width, height: 0)
        }
    }
}

enum SelectPosition {
    case top
    case bottom
}

enum AlertType {
    case success
    case warning
    case failure
}
