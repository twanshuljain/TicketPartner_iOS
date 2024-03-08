//
//  CreatEventVC.swift
//  TicketSpark
//
//  Created by Apple on 12/02/24.
//

import UIKit
import WebKit
import GoogleMaps

protocol RichTextEditiorDelegate: AnyObject {
    func getRichText(text : String?)
}

protocol APICallbackDelegate: AnyObject {
    func apiCallFinished()
}

class CreatEventVC: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEventTitle: CustomTextFieldView!
    @IBOutlet weak var imgCoverImage: UIImageView!
    @IBOutlet weak var imgViewAdd1: UIImageView!
    @IBOutlet weak var txtDrpEventType: DropDownTextField!
    @IBOutlet weak var txtDrpTimeZone: DropDownTextField!
    @IBOutlet weak var lblEventCover: UILabel!
    @IBOutlet weak var lblEventType: UILabel!
    @IBOutlet weak var lblAddMoreImageEvent: UILabel!
    @IBOutlet weak var lblAddMoreImagePastMedia: UILabel!
    @IBOutlet weak var lblDescribeEvent: UILabel!
    @IBOutlet weak var lblEventStartEnd: UILabel!
    @IBOutlet weak var lblMediaFromPast: UILabel!
    @IBOutlet weak var lblDoorOpenAt: UILabel!
    @IBOutlet weak var lblVenueType: UILabel!
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblDisplayEndTime: UILabel!
    @IBOutlet weak var lblTimeZone: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtStartDate: FloatingTextField!
    @IBOutlet weak var txtStartTime: FloatingTextField!
    @IBOutlet weak var txtEndDate: FloatingTextField!
    @IBOutlet weak var txtEndTime: FloatingTextField!
    @IBOutlet weak var txtDoorStartDate: FloatingTextField!
    @IBOutlet weak var txtDoorStartTime: FloatingTextField!
    @IBOutlet weak var txtDoorEndDate: FloatingTextField!
    @IBOutlet weak var txtDoorEndTime: FloatingTextField!
    @IBOutlet weak var txtDrpState: DropDownTextField!
    @IBOutlet weak var txtDrpCountry: DropDownTextField!
    @IBOutlet weak var viewOrganizationLogo: UIView!
    @IBOutlet weak var collectionViewCoverImages: UICollectionView!
    @IBOutlet weak var collectionViewPastImages: UICollectionView!
    @IBOutlet weak var imgViewPast: UIImageView!
    
    @IBOutlet weak var txtEventLink: CustomTextFieldView!
    @IBOutlet weak var txtTobeAnnouncedCity: CustomTextFieldView!
    @IBOutlet weak var txtTobeAnnouncedState: DropDownTextField!
    @IBOutlet weak var txtTobeAnnouncedCountry: DropDownTextField!
    
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var viewStartTime: UIView!
    @IBOutlet weak var viewEndDate: UIView!
    @IBOutlet weak var viewEndTime: UIView!
    @IBOutlet weak var viewDoorStartDate: UIView!
    @IBOutlet weak var viewDoorStartTime: UIView!
    @IBOutlet weak var viewDoorEndDate: UIView!
    @IBOutlet weak var viewDoorEndTime: UIView!
    @IBOutlet weak var descriptionWebView: WKWebView!
    
    // MARK: - CENTER X Constraints
    @IBOutlet weak var startDateCenterCons: NSLayoutConstraint!
    @IBOutlet weak var startTimeCenterCons: NSLayoutConstraint!
    @IBOutlet weak var endDateCenterCons: NSLayoutConstraint!
    @IBOutlet weak var endTimeCenterCons: NSLayoutConstraint!
    
    @IBOutlet weak var closeStartDateCenterCons: NSLayoutConstraint!
    @IBOutlet weak var closeStartTimeCenterCons: NSLayoutConstraint!
    @IBOutlet weak var closeEndTimeCenterCons: NSLayoutConstraint!
    @IBOutlet weak var closeEndDateCenterCons: NSLayoutConstraint!
    
    @IBOutlet weak var txtLocationName: CustomTextFieldView!
    @IBOutlet weak var txtStreetAddress: CustomTextFieldView!
    @IBOutlet weak var txtCity: CustomTextFieldView!
    @IBOutlet weak var stackMediafromPast: UIStackView!
    @IBOutlet weak var stackSendEmailConfirmation: UIStackView!
    @IBOutlet weak var switchMediaPastEvent: UISwitch!
    @IBOutlet weak var switchSendEmailConfirmation: UISwitch!
    @IBOutlet weak var btnnSaveAndContinue: NextButton!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var stackViewVenue: UIStackView!
    @IBOutlet weak var stackViewVirtual: UIStackView!
    @IBOutlet weak var stackViewToBeAnnounced: UIStackView!
    @IBOutlet weak var lblSendAddress: UILabel!
    
    @IBOutlet weak var btnDeleteCoverImage: UIButton!
    
    @IBOutlet weak var lblVirtualEventLink: UILabel!
    
    @IBOutlet weak var lblToBeAnnouncedCity: UILabel!
    @IBOutlet weak var lblToBeAnnouncedState: UILabel!
    @IBOutlet weak var lblToBeAnnouncedCountry: UILabel!
    @IBOutlet weak var lblToBeAnnouncedSendConfirmation: UILabel!
    @IBOutlet weak var txtLocationToBeAnnounced: CustomTextFieldView!
    
    @IBOutlet weak var switchDisplayEvent: UISwitch!
    
    @IBOutlet weak var mapViewToBeAnnounced: GMSMapView!
    @IBOutlet weak var mapViewVenue: GMSMapView!
    
    // MARK: - Variables
    var delegate : RichTextEditiorDelegate?
    var richTextString : String = ""
    var htmlCallbackState : Bool = false
    var editedText : String = ""
    let viewModel = CreatEventViewModel()
    var marker: GMSMarker?
    var delegateApiCall: APICallbackDelegate?
    
    var isCoverImagePicked = false {
        didSet {
            if isCoverImagePicked {
                btnDeleteCoverImage.isHidden = false
            } else {
                btnDeleteCoverImage.isHidden = true
            }
        }
    }
    
    var changeSegment = 0 {
        didSet {
            if changeSegment == 0 {
                stackViewVenue.isHidden = false
                stackViewVirtual.isHidden = true
                stackViewToBeAnnounced.isHidden = true
            } else if changeSegment == 1 {
                stackViewVenue.isHidden = true
                stackViewVirtual.isHidden = false
                stackViewToBeAnnounced.isHidden = true
            } else if changeSegment == 2 {
                stackViewVenue.isHidden = true
                stackViewVirtual.isHidden = true
                stackViewToBeAnnounced.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.apiCallForGetTimeZone()
    }
}

// MARK: - Functions
extension CreatEventVC {
    // MARK: - SetUp Navigation
    func setView() {
        setUI()
        descriptionWebView.navigationDelegate = self
        descriptionWebView.configuration.userContentController.add(self, name: "content")
        setupWebView()
        loadQuillEditor()
        self.addAction()
        self.setDatePicker()
    }
    
    func setDatePicker() {
       let dateFields = [txtStartDate, txtEndDate, txtDoorStartDate, txtDoorEndDate]
        dateFields.forEach { field in
            field?.delegate = self
            field?.addDatePicker(minimumDate: Date(), maximumDate: nil)
        }
        
        let timeFields = [txtStartTime, txtEndTime, txtDoorStartTime, txtDoorEndTime]
        timeFields.forEach { field in
            field?.delegate = self
            field?.addTimePicker(minimumDate: Date(), maximumDate: nil)
        }
        
        txtDoorStartDate.isUserInteractionEnabled = false
        txtDoorEndDate.isUserInteractionEnabled = false
        
    }
    
    // MARK: - SetUpUI
    func setUI() {
        let txtBorders = [txtTobeAnnouncedState, txtTobeAnnouncedCountry, txtDrpEventType, txtDrpTimeZone, viewStartDate, viewStartTime, viewEndDate, viewEndTime, viewDoorStartDate, viewDoorStartTime, viewDoorEndDate, viewDoorEndTime, txtDrpState, txtDrpCountry]
        for txtBorder in txtBorders {
            txtBorder?.setTextFiledBorder()
        }
        let lbls = [lblEventType, lblDescribeEvent, lblEventCover, lblAddMoreImageEvent, lblAddMoreImagePastMedia, lblMediaFromPast, lblDoorOpenAt, lblEventStartEnd, lblTimeZone, lblState, lblCountry, lblToBeAnnouncedState, lblToBeAnnouncedCountry]
        for lbl in lbls {
            lbl?.font = CustomFont.shared.medium(sizeOfFont: 14)
            lbl?.textColor = .appBlackTextColor
        }
        lblToBeAnnouncedSendConfirmation.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblToBeAnnouncedSendConfirmation.textColor = .appBlackTextColor
        self.setDelegate()
        lblDisplayEndTime.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblDisplayEndTime.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblDateTime.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblLocation.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        txtDrpEventType.font = CustomFont.shared.regular(sizeOfFont: 16)
        txtDrpEventType.placeholder = StringConstants.CreateEvent.selectEventType.value
        
        txtTobeAnnouncedState.font = CustomFont.shared.regular(sizeOfFont: 16)
        txtTobeAnnouncedState.placeholder = StringConstants.CreateEvent.selectEventType.value
        txtTobeAnnouncedState.optionArray = ["Hardy Sandu", "KK", "AR Rehman", "Arjit singh"]
        
        txtTobeAnnouncedCountry.font = CustomFont.shared.regular(sizeOfFont: 16)
        txtTobeAnnouncedCountry.placeholder = StringConstants.CreateEvent.enterCountry.value
        
        let text = StringConstants.CreateEvent.eventName.value + "*"
        txtEventTitle.lbl.attributedText = text.addAttributedString(highlightedString: "*")
        txtStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtStartDate._placeholder = StringConstants.CreateEvent.startDate.value
        txtStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        txtStartTime._placeholder = StringConstants.CreateEvent.startTime.value
        txtEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtEndDate._placeholder = StringConstants.CreateEvent.endDate.value
        txtEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        txtEndTime._placeholder = StringConstants.CreateEvent.endTime.value
        txtDoorEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtDoorEndDate._placeholder = StringConstants.CreateEvent.endDate.value
        txtDoorEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        txtDoorEndTime._placeholder = StringConstants.CreateEvent.endTime.value
        txtDoorStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtDoorStartDate._placeholder = StringConstants.CreateEvent.startDate.value
        txtDoorStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        txtDoorStartTime._placeholder = StringConstants.CreateEvent.startTime.value
        let txtDates = [txtStartDate, txtStartTime, txtEndDate, txtEndTime, txtDoorEndDate, txtDoorEndTime, txtDoorStartDate, txtDoorStartTime]
        for txtDate in txtDates {
            txtDate?.floatingLabelFont = CustomFont.shared.regular(sizeOfFont: 12)
            txtDate?.font = CustomFont.shared.semiBold(sizeOfFont: 14)
        }
//        txtStartDate.editingBegin = {
//            self.startDateCenterCons.constant = 10
//        }
//        txtStartTime.editingBegin = {
//            self.startTimeCenterCons.constant = 10
//        }
//        txtEndDate.editingBegin = {
//            self.endDateCenterCons.constant = 10
//        }
//        txtEndTime.editingBegin = {
//            self.endTimeCenterCons.constant = 10
//        }
//        txtDoorEndDate.editingBegin = {
//            self.closeEndDateCenterCons.constant = 10
//        }
//        txtDoorEndTime.editingBegin = {
//            self.closeEndTimeCenterCons.constant = 10
//        }
//        txtDoorStartDate.editingBegin = {
//            self.closeStartDateCenterCons.constant = 10
//        }
//        txtDoorStartTime.editingBegin = {
//            self.closeStartTimeCenterCons.constant = 10
//        }
        
        lblEventCover.attributedText = StringConstants.CreateEvent.coverImage.value.addAttributedString(highlightedString: "*")
        lblEventStartEnd.attributedText = StringConstants.CreateEvent.eventDate.value.addAttributedString(highlightedString: "*")
        lblDoorOpenAt.attributedText = StringConstants.CreateEvent.eventDoorDate.value.addAttributedString(highlightedString: "*")
        
        txtLocationName.lbl.text = StringConstants.CreateEvent.locationName.value
            //.addAttributedString(highlightedString: "*")
        txtLocationName.txtFld.placeholder = StringConstants.CreateEvent.enterLocation.value
        
        txtLocationToBeAnnounced.lbl.text = StringConstants.CreateEvent.location.value
            //.addAttributedString(highlightedString: "*")
        txtLocationToBeAnnounced.txtFld.placeholder = StringConstants.CreateEvent.enterLocation.value
        
       // txtEventLink.lbl.attributedText = StringConstants.CreateEvent.eventLink.value.addAttributedString(highlightedString: "*")
        txtEventLink.lbl.attributedText = StringConstants.CreateEvent.joinEvent.value.addAttributedString(highlightedString: "*")
        txtEventLink.txtFld.placeholder = StringConstants.CreateEvent.eventLink.value
        
        txtTobeAnnouncedCity.lbl.attributedText = StringConstants.CreateEvent.city.value.addAttributedString(highlightedString: "*")
        txtTobeAnnouncedCity.txtFld.placeholder = StringConstants.CreateEvent.enterCity.value
        
        self.txtDrpTimeZone.placeholder = StringConstants.CreateEvent.selectTimeZone.value
       // self.txtDrpTimeZone.setDelegate(vc: self)
        
        txtCity.lbl.attributedText = StringConstants.CreateEvent.city.value.addAttributedString(highlightedString: "*")
        txtCity.txtFld.placeholder = StringConstants.CreateEvent.enterCity.value
        
        lblToBeAnnouncedState.attributedText = StringConstants.CreateEvent.state.value.addAttributedString(highlightedString: "*")
        
        lblToBeAnnouncedCountry.attributedText = StringConstants.CreateEvent.country.value.addAttributedString(highlightedString: "*")
        
        
        
        txtStreetAddress.lbl.text = StringConstants.CreateEvent.streetAddress.value
        //.addAttributedString(highlightedString: "*")
        lblState.attributedText = StringConstants.CreateEvent.state.value.addAttributedString(highlightedString: "*")
        lblCountry.attributedText = StringConstants.CreateEvent.country.value.addAttributedString(highlightedString: "*")
        lblEventType.attributedText = StringConstants.CreateEvent.eventType.value.addAttributedString(highlightedString: "*")
        lblDescribeEvent.attributedText = StringConstants.CreateEvent.description.value.addAttributedString(highlightedString: "*")
        lblTimeZone.attributedText = StringConstants.CreateEvent.timeZone.value.addAttributedString(highlightedString: "*")
        txtStreetAddress.txtFld.placeholder = StringConstants.CreateEvent.enterStreetAddress.value
        
        switchDisplayEvent.isOn = false
        switchMediaPastEvent.isOn = false
        stackMediafromPast.isHidden = true
        
        stackSendEmailConfirmation.isHidden = true
        switchSendEmailConfirmation.isOn = false
        
        switchDisplayEvent.addTarget(self, action: #selector(actionSwitchDisplayEvent(_ :)), for: .valueChanged)
        switchMediaPastEvent.addTarget(self, action: #selector(actionSwitchMediaPast(_ :)), for: .valueChanged)
        switchSendEmailConfirmation.addTarget(self, action: #selector(actionSendEmailConfirmation(_ :)), for: .valueChanged)
        txtDrpState.placeholder = StringConstants.CreateEvent.enterState.value
        txtDrpCountry.placeholder = StringConstants.CreateEvent.enterCountry.value
        txtDrpCountry.font = CustomFont.shared.regular(sizeOfFont: 14)
        txtDrpState.font = CustomFont.shared.regular(sizeOfFont: 14)
        btnnSaveAndContinue.title = StringConstants.CreateEvent.saveAndContinue.value
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(addPastImageTapped(_:)))

        imgViewAdd1.isUserInteractionEnabled = true
        imgViewAdd1.tag = 10
        imgViewAdd1.addGestureRecognizer(tapGestureRecognizer)
        
        imgViewPast.isUserInteractionEnabled = true
        imgViewPast.tag = 20
        imgViewPast.addGestureRecognizer(tapGestureRecognizer1)
        
        self.isCoverImagePicked = self.viewModel.createEventReq.eventCoverImage == nil ? false : true
        
        let dropDowns = [txtDrpEventType,txtDrpTimeZone,txtDrpState,txtDrpCountry,txtTobeAnnouncedState,txtTobeAnnouncedCountry]
        dropDowns.forEach { data in
            data?.completionForSelection = { [self]  txtField in
                switch txtField {
                case self.txtDrpEventType :
                    self.viewModel.eventTypeData.forEach { data in
                        if data.eventTypeTitle == self.txtDrpEventType.text {
                            self.viewModel.createEventReq.eventTypeId = data.id
                        }
                    }
                case self.txtDrpTimeZone :
                    self.viewModel.timeZoneData.forEach { data in
                        if data.timeZoneName == self.txtDrpTimeZone.text {
                            self.viewModel.createEventReq.timeZoneId = data.id
                        }
                    }
                case self.txtDrpState :
                    break;
//                    self.viewModel.eventTypeData.forEach { data in
//                        if data.eventTypeTitle == self.txtDrpState.text {
//                            self.viewModel.createEventReq.eventTypeId = data.id
//                        }
//                    }
                case self.txtDrpCountry :
                    self.viewModel.countryData.forEach { data in
                        if data.countryName == self.txtDrpCountry.text {
                            self.viewModel.createEventReq.country = data.countryName
                        }
                    }
                case self.txtTobeAnnouncedState :
                    self.viewModel.eventTypeData.forEach { data in
                        if data.eventTypeTitle == self.txtTobeAnnouncedState.text {
                            self.viewModel.createEventReq.eventTypeId = data.id
                        }
                    }
                case self.txtTobeAnnouncedCountry :
                    self.viewModel.countryData.forEach { data in
                        if data.countryName == self.txtTobeAnnouncedCountry.text {
                            self.viewModel.createEventReq.country = data.countryName ?? ""
                        }
                    }
                default:
                    break;
                }
            }
        }
    }
    
    func setDelegate() {
        self.collectionViewCoverImages.register(UINib(nibName: "CoverImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoverImageCollectionViewCell")
        self.collectionViewPastImages.register(UINib(nibName: "PastImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PastImageCollectionViewCell")
        self.txtEventTitle.txtFld.delegate = self
        self.txtLocationName.txtFld.delegate = self
        self.txtLocationToBeAnnounced.txtFld.delegate = self
        self.txtStreetAddress.txtFld.delegate = self
        self.txtCity.txtFld.delegate = self
     //   self.txtDrpState.delegate = self
      //  self.txtDrpCountry.delegate = self
        self.txtEventLink.txtFld.delegate = self
        self.txtTobeAnnouncedCity.txtFld.delegate = self
    //    self.txtTobeAnnouncedState.txtFld.delegate = self
    //    self.txtTobeAnnouncedCountry.txtFld.delegate = self
    }
    
    func apiCallForGetTimeZone(){
   //     self.txtDrpTimeZone.apiCall = {
    //        if self.txtDrpTimeZone.optionArray.count != 0 { return }
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
               self.viewModel.dispatchGroup.enter()
                self.viewModel.getTimeZoneList() { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if let response = response {
                                self.viewModel.timeZoneData = response
                                self.txtDrpTimeZone.optionArray = self.viewModel.timeZoneData.compactMap( { $0.timeZoneName ?? "" } )
                       //     self.delegateApiCall?.apiCallFinished()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                        }
                    }
                }
            } else {
                self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
            }
    //    }
        self.viewModel.dispatchGroup.notify(queue: .main) {
            self.apiCallForGetCountryList()
        }
    }
    
    func apiCallForGetCountryList(){
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.dispatchGroup1.enter()
            self.viewModel.getCountryList() { isSuccess, response, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                    if let response = response {
                        self.viewModel.countryData = response
                        self.txtDrpCountry.optionArray = self.viewModel.countryData.compactMap( { $0.countryName ?? "" } )
                        self.txtTobeAnnouncedCountry.optionArray = self.viewModel.countryData.compactMap( { $0.countryName ?? "" } )
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                    }
                }
            }
        } else {
            self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
        }
        
        self.viewModel.dispatchGroup1.notify(queue: .main) {
            self.apiCallForGetEventType()
        }
    }
    
    func apiCallForGetEventType(){
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.getEventType() { isSuccess, response, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                    if let response = response {
                        self.viewModel.eventTypeData = response
                        self.txtDrpEventType.optionArray = self.viewModel.eventTypeData.compactMap( { $0.eventTypeTitle ?? "" } )
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                    }
                }
            }
        } else {
            self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
        }
    }
    
    // MARK: - AddAction
    func addAction() {
        btnnSaveAndContinue.actionSubmit = { [weak self] _ in
            if let self {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketsCreateEventVC") as! TicketsCreateEventVC
//                self.navigationController?.pushViewController(vc, animated: true)
                self.apiCallForCreateEventBasics()
            }
        }
    }
    
    @objc func deletAdditionalImages(_ sender: UIButton) {
        let data = self.viewModel.createEventReq.eventAdditionalCoverImagesList?[sender.tag]
        self.viewModel.createEventReq.eventAdditionalCoverImagesList?.removeAll(where: { $0 == data })
        self.collectionViewCoverImages.reloadData()
    }
    
    @objc func deletAdditionalPastImages(_ sender: UIButton) {
        let data = self.viewModel.createEventReq.mediaFromPastEventImages?[sender.tag]
        self.viewModel.createEventReq.mediaFromPastEventImages?.removeAll(where: { $0 == data })
        self.collectionViewPastImages.reloadData()
    }
    
    @objc func actionSwitchDisplayEvent(_ sender: UISwitch) {
        self.viewModel.createEventReq.isEndTimeShow = sender.isOn
    }
    
    @objc func actionSwitchMediaPast(_ sender: UISwitch) {
        stackMediafromPast.isHidden = !sender.isOn
    }
    
    @objc func actionSendEmailConfirmation(_ sender: UISwitch) {
        stackSendEmailConfirmation.isHidden = !sender.isOn
    }
    // MARK: - WebView Setup
    func setupWebView() {
        let viewportScriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let disableSelectionScriptString = "document.documentElement.style.webkitUserSelect='none';"
        let disableCalloutScriptString = "document.documentElement.style.webkitTouchCallout='none';"
        
        let viewportScript = WKUserScript(source: viewportScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let disableSelectionScript = WKUserScript(source: disableSelectionScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let disableCalloutScript = WKUserScript(source: disableCalloutScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        descriptionWebView.configuration.userContentController.addUserScript(viewportScript)
        descriptionWebView.configuration.userContentController.addUserScript(disableSelectionScript)
        descriptionWebView.configuration.userContentController.addUserScript(disableCalloutScript)
    }
    func loadHtmlData() {
        if !editedText.isEmpty{
            let javascriptFunction = "setQuillContent('\(editedText)');"
            descriptionWebView.evaluateJavaScript(javascriptFunction, completionHandler: nil)
        }
    }
    func loadQuillEditor() {
        if let htmlFilePath = Bundle.main.path(forResource: "quill", ofType: "html") {
            let htmlFileURL = URL(fileURLWithPath: htmlFilePath)
            descriptionWebView.loadFileURL(htmlFileURL, allowingReadAccessTo: htmlFileURL)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                self.loadHtmlData()
            })
        }
    }
    func setQuillContent(htmlContent: String) {
        let javascriptFunction = "setQuillContent('\(htmlContent)');"
        descriptionWebView.evaluateJavaScript(javascriptFunction, completionHandler: { (_, error) in
            if let error = error {
                print("Error setting Quill content: \(error.localizedDescription)")
            } else {
                print("Quill content set successfully.")
            }
        })
    }
    
    func apiCallForCreateEventBasics(){
        let isValidate = self.viewModel.validateFields(self.viewModel.createEventReq)
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                let req =  self.viewModel.createEventReq
                self.viewModel.createEventBasics(createEventBasicRequest: req) { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if let response = response {
                            print(response)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                        }
                    }
                }
            } else {
                self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
            }
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
                switch isValidate.2 {
                case .eventName: self.viewModel.scrollToTextField(self.txtEventTitle, scrollView: self.scrollView)
                case .eventType: self.viewModel.scrollToTextField(self.txtDrpEventType, scrollView: self.scrollView)
                case .eventCover: self.viewModel.scrollToTextField(self.imgCoverImage, scrollView: self.scrollView)
                case .timeZone: self.viewModel.scrollToTextField(self.txtDrpTimeZone, scrollView: self.scrollView)
                case .eventStartDate: self.viewModel.scrollToTextField(self.txtStartDate, scrollView: self.scrollView)
                case .eventEndDate: self.viewModel.scrollToTextField(self.txtEndDate, scrollView: self.scrollView)
                case .eventStartTime: self.viewModel.scrollToTextField(self.txtStartTime, scrollView: self.scrollView)
                case .eventEndTime: self.viewModel.scrollToTextField(self.txtEndTime, scrollView: self.scrollView)
                case .eventDoorOpenDate: self.viewModel.scrollToTextField(self.txtDoorStartTime, scrollView: self.scrollView)
                case .eventDoorCloseDate: self.viewModel.scrollToTextField(self.txtDoorEndDate, scrollView: self.scrollView)
                case .eventDoorOpenTime: self.viewModel.scrollToTextField(self.txtDoorStartTime, scrollView: self.scrollView)
                case .eventDoorCloseTime: self.viewModel.scrollToTextField(self.txtDoorEndTime, scrollView: self.scrollView)
                case .eventCountryVenue: self.viewModel.scrollToTextField(self.txtTobeAnnouncedCountry, scrollView: self.scrollView)
                case .eventStateVenue: self.viewModel.scrollToTextField(self.txtDrpState, scrollView: self.scrollView)
                case .eventCityVenue: self.viewModel.scrollToTextField(self.txtCity, scrollView: self.scrollView)
                case .eventLinkVirtual: self.viewModel.scrollToTextField(self.txtEventLink, scrollView: self.scrollView)
                case .eventCountryToBeAnnounced: self.viewModel.scrollToTextField(self.txtTobeAnnouncedCountry, scrollView: self.scrollView)
                case .eventStateToBeAnnounced: self.viewModel.scrollToTextField(self.txtTobeAnnouncedState, scrollView: self.scrollView)
                case .eventCityToBeAnnounced: self.viewModel.scrollToTextField(self.txtTobeAnnouncedCity, scrollView: self.scrollView)
                case .eventLocationToBeAnnounced: self.viewModel.scrollToTextField(self.txtLocationToBeAnnounced, scrollView: self.scrollView)
                case .none:
                    break;
                }
            }
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
          // Display the selected view controller based on the segmented control index
          switch sender.selectedSegmentIndex {
          case 0:
              self.changeSegment = 0
          case 1:
              self.changeSegment = 1
          case 2:
              self.changeSegment = 2
          default:
              break
          }
      }
    
    @objc func cellTappedMethod(_ sender:AnyObject) {
        ImagePickerManager().pickImage(self) { image in
            if self.viewModel.createEventReq.eventAdditionalCoverImagesList == nil {
                self.viewModel.createEventReq.eventAdditionalCoverImagesList = [image.convertImageToData()]
            } else {
                self.viewModel.createEventReq.eventAdditionalCoverImagesList?.append(image.convertImageToData())
            }
            self.collectionViewCoverImages.reloadData()
        }
    }
    
    @objc func addPastImageTapped(_ sender:AnyObject) {
        ImagePickerManager().pickImage(self) { image in
            if self.viewModel.createEventReq.mediaFromPastEventImages == nil {
                self.viewModel.createEventReq.mediaFromPastEventImages = [image.convertImageToData()]
            } else {
                self.viewModel.createEventReq.mediaFromPastEventImages?.append(image.convertImageToData())
            }
            self.collectionViewPastImages.reloadData()
        }
    }
    
    @IBAction func btnImageUploadAction(_ sender: UIButton) {
        ImagePickerManager().pickImage(self) { image in
            self.viewModel.createEventReq.eventCoverImage = image.convertImageToData()
            self.imgCoverImage.image = UIImage(data: self.viewModel.createEventReq.eventCoverImage ?? Data())
            self.isCoverImagePicked = self.viewModel.createEventReq.eventCoverImage == nil ? false : true
        }
    }
    
    @IBAction func btnDeleteCoverImageAction(_ sender: UIButton) {
        self.viewModel.createEventReq.eventCoverImage = nil
        self.isCoverImagePicked = self.viewModel.createEventReq.eventCoverImage == nil ? false : true
        self.imgCoverImage.image = nil
    }
}


//WebView deleagate
extension CreatEventVC : WKNavigationDelegate, WKScriptMessageHandler {
    // Handle content messages from JavaScript
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "content", let content = message.body as? String {
            // Handle the received content from Quill editor
            richTextString = content
            self.htmlCallbackState = true
            print("Received content from Quill editor: \(content)")
        }
    }
}

// MARK: - UITextFieldDelegate
extension CreatEventVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case self.txtStartDate:
            txtStartDate.addDatePicker(minimumDate: Date(), maximumDate: self.txtEndDate.text?.convertStringToDateFormatMMDDYYY() ?? nil)
        case self.txtEndDate:
            txtEndDate.addDatePicker(minimumDate: txtStartDate.text?.convertStringToDateFormatMMDDYYY(), maximumDate: nil)
        case self.txtStartTime:
             txtStartTime.addTimePicker(minimumDate: txtStartDate.text != self.txtEndDate.text ? nil :  txtStartDate.text?.convertStringToTimeHMMA(), maximumDate: txtEndTime.text?.convertStringToTimeHMMA() ?? nil)
        case self.txtEndTime:
            txtEndTime.addTimePicker(minimumDate: txtStartDate.text != self.txtEndDate.text ? nil : txtStartDate.text?.convertStringToTimeHMMA(), maximumDate: nil)
        case self.txtDoorStartTime:
            txtStartTime.addTimePicker(minimumDate: txtStartTime.text?.convertStringToTimeHMMA(), maximumDate: txtEndTime.text?.convertStringToTimeHMMA() ?? nil)
        case self.txtDoorEndTime:
            txtDoorEndTime.addTimePicker(minimumDate: txtStartDate.text?.convertStringToTimeHMMA(), maximumDate: self.txtEndDate.text?.convertStringToTimeHMMA() ?? nil)
        default:
            break;
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.txtStartDate:
            self.txtDoorStartDate.text = self.txtStartDate.text ?? ""
        case self.txtEndDate:
            self.txtDoorEndDate.text = self.txtEndDate.text ?? ""
        case self.txtEventTitle.txtFld:
            self.viewModel.createEventReq.name = textField.text
        //Venue
        case self.txtLocationName:
            self.viewModel.createEventReq.locationName = textField.text
        case self.txtStreetAddress:
            self.viewModel.createEventReq.eventAddress = textField.text
        case self.txtCity:
            self.viewModel.createEventReq.city = textField.text
         //Virtual
        case self.txtEventLink:
            self.viewModel.createEventReq.virtualEventLink = textField.text
        //ToBeAnnounced
        case self.txtTobeAnnouncedCity:
            self.viewModel.createEventReq.announceCity = textField.text
        case self.txtLocationToBeAnnounced:
            self.viewModel.createEventReq.announceEventAddress = textField.text
        default:
            break
        }
    }
}
// MARK: - UITextFieldDelegate
extension CreatEventVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionViewCoverImages {
            return 1
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCoverImages {
            return self.viewModel.createEventReq.eventAdditionalCoverImagesList?.count ?? 0
        } else {
            return self.viewModel.createEventReq.mediaFromPastEventImages?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCoverImages {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoverImageCollectionViewCell", for: indexPath) as! CoverImageCollectionViewCell
           let data = self.viewModel.createEventReq.eventAdditionalCoverImagesList?[indexPath.row]
           cell.btnDeleteCoverImage.addTarget(self, action: #selector(deletAdditionalImages(_ :)), for: .touchUpInside)
           cell.setData(indexPath: indexPath, imgData: data)
           return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastImageCollectionViewCell", for: indexPath) as! PastImageCollectionViewCell
           let data = self.viewModel.createEventReq.mediaFromPastEventImages?[indexPath.row]
           cell.btnDeleteCoverImage.addTarget(self, action: #selector(deletAdditionalPastImages(_ :)), for: .touchUpInside)
           cell.setData(indexPath: indexPath, imgData: data)
           return cell
        }
         
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 62)
    }
}
