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
        
        self.setTextView()
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
    
    func setDelegate() {
        self.txtTicketName.txtFld.delegate = self
        self.txtQuantity.txtFld.delegate = self
        self.txtPrice.txtFld.delegate = self
        self.txtMinOrder.txtFld.delegate = self
        self.txtMaxOrder.txtFld.delegate = self
        self.txtTicketPerUser.txtFld.delegate = self
    }
    
    func setTextView() {
        txtDescription.delegate = self
        txtDescription.text = "Enter detail"
        txtDescription.textColor = UIColor.lightGray
       // txtDescription.becomeFirstResponder()
        txtDescription.selectedTextRange = txtDescription.textRange(from: txtDescription.beginningOfDocument, to: txtDescription.beginningOfDocument)
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
        
        txtDrpFees.placeholder = "Select Currency"
        
        let borderView = [txtDrpFees, txtDescription, txtDescription, txtDrpTicketVisibility, viewStartDate, viewStartTime, viewEndDate, viewEndTime]
        
        txtDrpTicketVisibility.optionArray = ["Visible", "Sold Out", "Hidden"]
        
        for view in borderView {
            view?.setTextFiledBorder()
        }
        txtStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        txtEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        let txtDates = [txtStartDate, txtStartTime, txtEndDate, txtEndTime]
        for txtDate in txtDates {
            txtDate?.delegate = self
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
        
        let dropDowns = [txtDrpTicketVisibility]
        dropDowns.forEach { data in
            data?.completionForSelection = { [self]  txtField in
                switch txtField {
                case self.txtDrpTicketVisibility :
                    self.txtDrpTicketVisibility.text = txtField.text ?? ""
                    self.viewModel.createTicketRequest.ticketVisibility = self.txtDrpTicketVisibility.text?.uppercased().replacingOccurrences(of: " ", with: "")
                default:
                    break;
                }
            }
        }
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
            self.viewModel.createTicketRequest.advanceSetting = !sender.isOn
        }
        if !sender.isOn {
            switchTicketPerUser.isOn = false
            self.txtTicketPerUser.isHidden = !switchTicketPerUser.isOn
            self.viewModel.createTicketRequest.ticketPerUser = !switchTicketPerUser.isOn
        }
    }
    @objc func actionTicketsPerUser(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.2) {
            self.txtTicketPerUser.isHidden = !sender.isOn
            self.viewModel.createTicketRequest.ticketPerUser = !sender.isOn
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

// MARK: - UITextFieldDelegate
extension TicketsCreateEventVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case self.txtStartDate:
            txtStartDate.addDatePicker(minimumDate: Date(), maximumDate: self.txtEndDate.text?.convertStringToDateFormatMMDDYYY() ?? nil)
        case self.txtEndDate:
            if self.viewModel.createTicketRequest.ticketSaleStartDate == nil {
                self.showToast(with: StringConstants.CreateEvent.ticketSaleStartDate.value, position: .top, type: .warning)
                return false
            }
            txtEndDate.addDatePicker(minimumDate: txtStartDate.text?.convertStringToDateFormatMMDDYYY(), maximumDate: nil)
        case self.txtStartTime:
            if self.viewModel.createTicketRequest.ticketSaleStartDate == nil {
                self.showToast(with: StringConstants.CreateEvent.ticketSaleStartDate.value, position: .top, type: .warning)
                return false
            }
             txtStartTime.addTimePicker(minimumDate: txtStartDate.text != Date().convertDateToStringFormatMMMDDYYY() ? nil :  Date(), maximumDate: nil)
        case self.txtEndTime:
            if self.viewModel.createTicketRequest.ticketSaleStartTime == nil {
                self.showToast(with: StringConstants.CreateEvent.ticketSaleStartTime.value, position: .top, type: .warning)
                return false
            }
            if txtStartDate.text == txtEndDate.text {
                let minDate = txtStartTime.text?.getMinMaxTime(startDate: txtStartDate.text ?? "")
               txtEndTime.addTimePicker(minimumDate: minDate, maximumDate: nil)
            } else {
                txtEndTime.addTimePicker(minimumDate: nil, maximumDate: nil)
            }
        default:
            break;
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case self.txtTicketName.txtFld:
            let newText = (self.txtTicketName.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketName = newText
        case self.txtQuantity.txtFld:
            let newText = (self.txtQuantity.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketQuantity = newText
        case self.txtPrice.txtFld:
            let newText = (self.txtPrice.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketPrice = newText
        case self.txtMinOrder.txtFld:
            let newText = (self.txtMinOrder.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketPerOrderMinimumQuantity = (newText as? NSString)?.integerValue
        case self.txtMaxOrder.txtFld:
            let newText = (self.txtMaxOrder.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketPerOrderMaximumQuantity = (newText as? NSString)?.integerValue
        case self.txtTicketPerUser.txtFld:
            let newText = (self.txtTicketPerUser.txtFld.text as? NSString)?.replacingCharacters(in: range, with: string)
            self.viewModel.createTicketRequest.ticketPerUserQuantity = (newText as? NSString)?.integerValue
        default:
            break;
        }
        return true
    }
    
}
// MARK: - UITextViewDelegate
extension TicketsCreateEventVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter detail"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Enter detail"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
            self.viewModel.createTicketRequest.ticketDescription = text
        }
        
        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
