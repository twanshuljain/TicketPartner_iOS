//
//  TicketEventListTableVC.swift
//  TicketSpark
//
//  Created by Apple on 22/02/24.
//

import UIKit

class TicketEventListTableVC: UITableViewCell {
    @IBOutlet weak var lblOnSale: UILabel!
    @IBOutlet weak var lblSaleValue: UILabel!
    @IBOutlet weak var lblFeeBreakDown: UILabel!
    @IBOutlet weak var lblTicketName: UILabel!
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var viewTicketType: UIView!
    @IBOutlet weak var mainTicketView: UIView!
    @IBOutlet weak var stepperView: CustomStepper!
    @IBOutlet weak var viewSell: UIView!
    @IBOutlet weak var btnAddOns: UIButton!
    @IBOutlet weak var btnCodes: UIButton!
    @IBOutlet weak var stackBtnAddesCodes: UIStackView!
    @IBOutlet weak var btnMenu: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        viewTicketType.layer.cornerRadius = viewTicketType.frame.height/2
        viewTicketType.layer.borderColor = UIColor.appBlueBGColor.cgColor
        viewTicketType.backgroundColor = .appBlueBGColor.withAlphaComponent(0.2)
        viewTicketType.layer.borderWidth = 1
        lblTicketType.font = CustomFont.shared.regular(sizeOfFont: 10)
        lblTicketType.textColor = .appBlueBGColor
        lblTicketName.font = CustomFont.shared.semiBold(sizeOfFont: 16)
        lblAmount.font = CustomFont.shared.bold(sizeOfFont: 18)
        lblFeeBreakDown.font = CustomFont.shared.semiBold(sizeOfFont: 9)
        lblOnSale.font = CustomFont.shared.regular(sizeOfFont: 10)
        lblSaleValue.font = CustomFont.shared.bold(sizeOfFont: 10)
        stepperView.layer.borderColor = UIColor.grayTextColor.cgColor
        stepperView.layer.borderWidth = 1
        stepperView.layer.cornerRadius = stepperView.frame.height/2
        viewSell.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        mainTicketView.setTextFiledBorder()
        btnAddOns.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 16)
        btnAddOns.tintColor = .appIndigoSelectedColor
        btnCodes.tintColor = .appIndigoSelectedColor
        btnCodes.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 16)
       
    }
}
