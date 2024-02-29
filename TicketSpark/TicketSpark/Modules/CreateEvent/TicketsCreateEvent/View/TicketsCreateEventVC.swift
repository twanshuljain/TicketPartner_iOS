//
//  TicketsCreateEventVC.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import UIKit

class TicketsCreateEventVC: UIViewController {

    // MARK: - IBOutlets
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
    @IBOutlet weak var txtTicketPerUser: CustomTextFieldView!
    
    @IBOutlet weak var txtStartDate: FloatingTextField!
    @IBOutlet weak var txtStartTime: FloatingTextField!
    @IBOutlet weak var txtEndDate: FloatingTextField!
    @IBOutlet weak var txtEndTime: FloatingTextField!
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var viewStartTime: UIView!
    @IBOutlet weak var viewEndDate: UIView!
    @IBOutlet weak var viewEndTime: UIView!
    
    // MARK: - CENTER X Constraints
    @IBOutlet weak var startDateCenterCons: NSLayoutConstraint!
    @IBOutlet weak var startTimeCenterCons: NSLayoutConstraint!
    @IBOutlet weak var endDateCenterCons: NSLayoutConstraint!
    @IBOutlet weak var endTimeCenterCons: NSLayoutConstraint!
    
    // MARK: - Hide and Show Stack
    @IBOutlet weak var stackAdvanceSetting: UIStackView!
    @IBOutlet weak var collectionViewTicketType: UICollectionView!
    
    @IBOutlet weak var btnCreateTicket: NextButton!
    
    
    // MARK: - Variables
    var viewModel = TicketCreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUI()
        setActions()
    }
}

// MARK: - Functions
extension TicketsCreateEventVC {
    func setCollectionView() {
        collectionViewTicketType.register(UINib(nibName: "TicketTypeCollectionVC", bundle: .main), forCellWithReuseIdentifier: "TicketTypeCollectionVC")
        collectionViewTicketType.dataSource = self
        collectionViewTicketType.delegate = self
        collectionViewTicketType.reloadData()
        
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
        lblFees.attributedText = StringConstants.CreateEvent.fees.value.addAttributedString(highlightedString: "*")
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
       
        lblTicketsPerUser.text = StringConstants.CreateEvent.ticketPerUser.value
        lblTicketsPerUser.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblTicketsPerUser.textColor = .appBlackTextColor
        lblTicketVisibility.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblTicketVisibility.attributedText = StringConstants.CreateEvent.ticketVisibilty.value.addAttributedString(highlightedString: "*")
        
        txtMaxOrder.lbl.isHidden = true
        txtMaxOrder.placeholder = StringConstants.CreateEvent.maximum.value
        txtMinOrder.lbl.isHidden = true
        txtMinOrder.placeholder = StringConstants.CreateEvent.minimum.value
        txtTicketPerUser.placeholder =  StringConstants.CreateEvent.enterTicketPerUser.value
        txtTicketPerUser.lbl.isHidden = true
        let borderView = [txtDrpFees, txtDescription, txtDescription, txtDrpTicketVisibility, viewStartDate, viewStartTime, viewEndDate, viewEndTime]
        
        for view in borderView {
            view?.setTextFiledBorder()
        }
        txtStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        txtEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        let txtDates = [txtStartDate, txtStartTime, txtEndDate, txtEndTime]
        for txtDate in txtDates {
            txtDate?.floatingLabelFont = CustomFont.shared.regular(sizeOfFont: 12)
            txtDate?.font = CustomFont.shared.semiBold(sizeOfFont: 14)
        }
        
        txtStartDate.editingBegin = {
            self.startDateCenterCons.constant = 10
        }
        txtStartTime.editingBegin = {
            self.startTimeCenterCons.constant = 10
        }
        txtEndDate.editingBegin = {
            self.endDateCenterCons.constant = 10
        }
        txtEndTime.editingBegin = {
            self.endTimeCenterCons.constant = 10
        }
        stackAdvanceSetting.isHidden = true
        txtTicketPerUser.isHidden = true
        switchSettings.isOn = false
        switchTicketPerUser.isOn = false
        btnCreateTicket.title = StringConstants.CreateEvent.createTicket.value
        
    }
    
    func setActions() {
        switchSettings.addTarget(self, action: #selector(self.actionSwitchSettings(_ :)), for: .valueChanged)
        switchTicketPerUser.addTarget(self, action: #selector(self.actionTicketsPerUser(_ :)), for: .valueChanged)
        btnCreateTicket.actionSubmit = { [weak self] _ in
            if let self {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketEventListViewController") as! TicketEventListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func actionSwitchSettings(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.2) {
            self.stackAdvanceSetting.isHidden = !sender.isOn
        }
        if !sender.isOn {
            switchTicketPerUser.isOn = false
            self.txtTicketPerUser.isHidden = !switchTicketPerUser.isOn
        }
    }
    @objc func actionTicketsPerUser(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.2) {
            self.txtTicketPerUser.isHidden = !sender.isOn
        }
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension TicketsCreateEventVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketTypeCollectionVC", for: indexPath) as! TicketTypeCollectionVC
        let data = viewModel.getItems(at: indexPath.row)
        cell.configureCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.ticketType.indices.forEach {
            viewModel.ticketType[$0].isSelected = false
        }
        viewModel.ticketType[indexPath.row].isSelected = true
        collectionViewTicketType.reloadData()
    }
}
