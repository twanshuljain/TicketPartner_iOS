//
//  TicketsCreateEventVC.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import UIKit

class TicketsCreateEventVC: UIViewController {

    @IBOutlet weak var lblFees: UILabel!
    @IBOutlet weak var lblBuyerPrice: UILabel!
    @IBOutlet weak var lblRevenuePerTicket: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblTicketStartEnd: UILabel!
   @IBOutlet weak var lblAdvancedSetting: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTicketsPerOrder: UILabel!
    @IBOutlet weak var lblTicketsPerUser: UILabel!
    @IBOutlet weak var lblTicketVisibility: UILabel!
    @IBOutlet weak var switchSettings: UISwitch!
    @IBOutlet weak var switchTicketPerUser: UISwitch!
    @IBOutlet weak var txtTicketName: CustomTextFieldView!
    @IBOutlet weak var txtQuantity: CustomTextFieldView!
    @IBOutlet weak var txtPrice: CustomTextFieldView!
    @IBOutlet weak var txtDrpFees: DropDownTextField!
    @IBOutlet weak var txtMinOrder: CustomTextFieldView!
    @IBOutlet weak var txtMaxOrder: CustomTextFieldView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtDrpTicketVisibility: DropDownTextField!
    
    @IBOutlet weak var txtStartDate: FloatingTextField!
    @IBOutlet weak var txtStartTime: FloatingTextField!
    @IBOutlet weak var txtEndDate: FloatingTextField!
    @IBOutlet weak var txtEndTime: FloatingTextField!
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var viewStartTime: UIView!
    @IBOutlet weak var viewEndDate: UIView!
    @IBOutlet weak var viewEndTime: UIView!
    
    @IBOutlet weak var btnCreateTicket: NextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    func setUI() {
        let ticketName = StringConstants.CreateEvent.ticketName.value + "*"
        txtTicketName.lbl.attributedText = ticketName.addAttributedString(highlightedString: "*")
        txtTicketName.placeholder = StringConstants.CreateEvent.ticketName.value
        
        txtQuantity.lbl.attributedText = StringConstants.CreateEvent.quantity.value.addAttributedString(highlightedString: "*")
        txtQuantity.placeholder = "0"
        txtPrice.lbl.attributedText = StringConstants.CreateEvent.price.value.addAttributedString(highlightedString: "*")
        txtPrice.placeholder = "0"
        lblBuyerPrice.text = StringConstants.CreateEvent.buyerPrice.value + "$1200"
        lblBuyerPrice.font = CustomFont.shared.regular(sizeOfFont: 12)
        lblBuyerPrice.textColor = .grayTextColor
        lblFees.text = StringConstants.CreateEvent.fees.value
        lblFees.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblRevenuePerTicket.text = StringConstants.CreateEvent.revenuePerTicket.value + "$1200"
        lblRevenuePerTicket.font = CustomFont.shared.regular(sizeOfFont: 12)
        lblRevenuePerTicket.textColor = .grayTextColor
        lblDateTime.text = StringConstants.CreateEvent.dateTime.value
        lblDateTime.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblDateTime.textColor = .appBlackTextColor
        lblTicketStartEnd.text = StringConstants.CreateEvent.ticketStartEnd.value
        lblTicketStartEnd.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblTicketStartEnd.textColor = .appBlackTextColor
        lblAdvancedSetting.text = StringConstants.CreateEvent.advanceSettings.value
        lblAdvancedSetting.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblAdvancedSetting.textColor = .appBlackTextColor
        lblDescription.text = StringConstants.CreateEvent.description.value
        lblDescription.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblDescription.textColor = .appBlackTextColor
        lblTicketsPerOrder.attributedText = StringConstants.CreateEvent.ticketPerOrder.value.addAttributedString(highlightedString: "*")
        lblTicketsPerOrder.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblTicketsPerOrder.textColor = .appBlackTextColor
        lblTicketsPerUser.text = StringConstants.CreateEvent.ticketPerUser.value
        lblTicketsPerUser.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblTicketsPerUser.textColor = .appBlackTextColor
        lblTicketVisibility.attributedText = StringConstants.CreateEvent.ticketVisibilty.value.addAttributedString(highlightedString: "*")
        lblTicketVisibility.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblTicketVisibility.textColor = .appBlackTextColor
        
        let borderView = [txtDrpFees, txtDescription, txtDescription, txtDrpTicketVisibility, viewStartDate, viewStartTime, viewEndDate, viewEndTime]
        
        for view in borderView {
            view?.setTextFiledBorder()
        }
    }
}
