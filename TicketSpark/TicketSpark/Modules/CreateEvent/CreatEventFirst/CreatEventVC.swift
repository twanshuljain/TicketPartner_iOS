//
//  CreatEventVC.swift
//  TicketSpark
//
//  Created by Apple on 12/02/24.
//

import UIKit
import WebKit

protocol RichTextEditiorDelegate: AnyObject {
    func getRichText(text : String?)
}

class CreatEventVC: BaseViewController {
    
    // MARK: - IBOutlets
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
    @IBOutlet weak var switchMediaPastEvent: UISwitch!
    @IBOutlet weak var btnnSaveAndContinue: NextButton!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var stackViewVenue: UIStackView!
    @IBOutlet weak var stackViewVirtual: UIStackView!
    @IBOutlet weak var stackViewToBeAnnounced: UIStackView!
    @IBOutlet weak var lblSendAddress: UILabel!
    
    @IBOutlet weak var btnDeleteCoverImage: UIButton!
    
    // MARK: - Variables
    var delegate : RichTextEditiorDelegate?
    var richTextString : String = ""
    var htmlCallbackState : Bool = false
    var editedText : String = ""
    let viewModel = CreatEventViewModel()
    
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
    }
    // MARK: - SetUpUI
    func setUI() {
        let txtBorders = [txtTobeAnnouncedState, txtTobeAnnouncedCountry, txtDrpEventType, txtDrpTimeZone, viewStartDate, viewStartTime, viewEndDate, viewEndTime, viewDoorStartDate, viewDoorStartTime, viewDoorEndDate, viewDoorEndTime, txtDrpState, txtDrpCountry]
        for txtBorder in txtBorders {
            txtBorder?.setTextFiledBorder()
        }
        let lbls = [lblEventType, lblDescribeEvent, lblEventCover, lblAddMoreImageEvent, lblAddMoreImagePastMedia, lblMediaFromPast, lblDoorOpenAt, lblEventStartEnd, lblTimeZone, lblState, lblCountry]
        for lbl in lbls {
            lbl?.font = CustomFont.shared.medium(sizeOfFont: 14)
            lbl?.textColor = .appBlackTextColor
        }
        self.setDelegate()
        lblDisplayEndTime.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblDisplayEndTime.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblDateTime.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblLocation.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        txtDrpEventType.font = CustomFont.shared.regular(sizeOfFont: 16)
        txtDrpEventType.placeholder = StringConstants.CreateEvent.selectEventType.value
        txtDrpEventType.optionArray = ["Hardy Sandu", "KK", "AR Rehman", "Arjit singh"]
        
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
        txtLocationName.lbl.attributedText = StringConstants.CreateEvent.locationName.value.addAttributedString(highlightedString: "*")
        txtLocationName.txtFld.placeholder = StringConstants.CreateEvent.enterLocation.value
        
        txtEventLink.lbl.attributedText = StringConstants.CreateEvent.locationName.value.addAttributedString(highlightedString: "*")
        txtEventLink.txtFld.placeholder = StringConstants.CreateEvent.eventLink.value
        
        txtTobeAnnouncedCity.lbl.attributedText = StringConstants.CreateEvent.locationName.value.addAttributedString(highlightedString: "*")
        txtTobeAnnouncedCity.txtFld.placeholder = StringConstants.CreateEvent.enterCity.value
        
        self.txtDrpTimeZone.placeholder = StringConstants.CreateEvent.selectTimeZone.value
        
        txtCity.lbl.attributedText = StringConstants.CreateEvent.city.value.addAttributedString(highlightedString: "*")
        txtCity.txtFld.placeholder = StringConstants.CreateEvent.enterCity.value
        
        txtStreetAddress.lbl.attributedText = StringConstants.CreateEvent.streetAddress.value.addAttributedString(highlightedString: "*")
        lblState.attributedText = StringConstants.CreateEvent.state.value.addAttributedString(highlightedString: "*")
        lblCountry.attributedText = StringConstants.CreateEvent.country.value.addAttributedString(highlightedString: "*")
        lblEventType.attributedText = StringConstants.CreateEvent.eventType.value.addAttributedString(highlightedString: "*")
        lblDescribeEvent.attributedText = StringConstants.CreateEvent.description.value.addAttributedString(highlightedString: "*")
        lblTimeZone.attributedText = StringConstants.CreateEvent.timeZone.value.addAttributedString(highlightedString: "*")
        txtStreetAddress.txtFld.placeholder = StringConstants.CreateEvent.enterStreetAddress.value
        switchMediaPastEvent.isOn = false
        stackMediafromPast.isHidden = true
        switchMediaPastEvent.addTarget(self, action: #selector(actionSwitchMediaPast(_ :)), for: .valueChanged)
        txtDrpState.placeholder = StringConstants.CreateEvent.enterState.value
        txtDrpCountry.placeholder = StringConstants.CreateEvent.enterCountry.value
        txtDrpCountry.font = CustomFont.shared.regular(sizeOfFont: 14)
        txtDrpState.font = CustomFont.shared.regular(sizeOfFont: 14)
        btnnSaveAndContinue.title = StringConstants.CreateEvent.saveAndContinue.value
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))

        imgViewAdd1.isUserInteractionEnabled = true
        imgViewAdd1.tag = 10
        imgViewAdd1.addGestureRecognizer(tapGestureRecognizer)
        self.isCoverImagePicked = self.viewModel.createEventReq.eventCoverImage == nil ? false : true
    }
    
    func setDelegate() {
        self.collectionViewCoverImages.register(UINib(nibName: "CoverImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoverImageCollectionViewCell")
        self.txtEventTitle.txtFld.delegate = self
        self.txtLocationName.txtFld.delegate = self
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
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.dispatchGroup.enter()
            self.viewModel.getTimeZoneList() { isSuccess, response, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                    if let response = response {
                        response.forEach { data in
                            self.viewModel.timeZoneData = response
                            self.viewModel.timeZoneData.forEach { data in
                                self.txtDrpTimeZone.optionArray.append(data.timeZoneName ?? "")
                            }
                        }
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
        
        self.viewModel.dispatchGroup.notify(queue: .main) {
            self.apiCallForGetCountryList()
        }
    }
    
    func apiCallForGetCountryList(){
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.getCountryList() { isSuccess, response, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                    if let response = response {
                        response.forEach { data in
                            self.viewModel.countryData = response
                            self.viewModel.countryData.forEach { data in
                                self.txtDrpCountry.optionArray.append(data.countryName ?? "")
                                self.txtTobeAnnouncedCountry.optionArray.append(data.countryName ?? "")
                            }
                            
                        }
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
    
    @objc func actionSwitchMediaPast(_ sender: UISwitch) {
        stackMediafromPast.isHidden = !sender.isOn
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
                let coverImage = UIImage(systemName: "imgDropDown")?.convertImageToData()
                let eventAdditionalCoverImagesList = [UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData()]
                let mediaFromPastEventImages = [UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData(), UIImage.init(systemName: "plus")?.convertImageToData()]
                
                let req =  CreateEventBasicRequest(name: "Rockyii122", eventDescription: "scsdds",eventStartDate: "2024-11-09",eventEndDate: "2024-11-09",doorCloseDate: "2024-11-09",doorStartDate: "2024-11-09",doorOpenTime: "11:00",doorCloseTime: "12:00",doorCloseTimeRepresents: "sds",doorOpenTimeRepresents: "csdc",eventTypeId: 2,eventCoverImage: coverImage,eventAdditionalCoverImagesList: eventAdditionalCoverImagesList,mediaFromPastEventImages: mediaFromPastEventImages,isVirtual: false,virtualEventLink: "",isVenue: true,locationName: "Indore Palasia",city: "Indore",stateId: "33",countryId: "21",eventAddress: "IndoreIndore",isToBeAnnounced: false,isEmail: false,state: "",country: "")
                
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.txtEventTitle.txtFld:
            self.viewModel.createEventReq.name = textField.text
        case self.txtLocationName:
            self.viewModel.createEventReq.locationName = textField.text
        case self.txtStreetAddress:
            self.viewModel.createEventReq.eventAddress = textField.text
        case self.txtCity:
            self.viewModel.createEventReq.city = textField.text
        case self.txtDrpState:
            self.viewModel.createEventReq.state = textField.text
        case self.txtDrpCountry:
            self.viewModel.createEventReq.country = textField.text
        case self.txtEventLink:
            self.viewModel.createEventReq.virtualEventLink = textField.text
        case self.txtTobeAnnouncedCity:
            self.viewModel.createEventReq.city = textField.text
//        case self.txtTobeAnnouncedState:
//            self.viewModel.createEvent?.eventLocationData?.state = textField.text
//        case self.txtTobeAnnouncedCountry:
//            self.viewModel.createEvent?.eventLocationData?.country = textField.text
        default:
            break
        }
    }
}
// MARK: - UITextFieldDelegate
extension CreatEventVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.createEventReq.eventAdditionalCoverImagesList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoverImageCollectionViewCell", for: indexPath) as! CoverImageCollectionViewCell
        let data = self.viewModel.createEventReq.eventAdditionalCoverImagesList?[indexPath.row]
        cell.btnDeleteCoverImage.addTarget(self, action: #selector(deletAdditionalImages(_ :)), for: .touchUpInside)
        cell.setData(indexPath: indexPath, imgData: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: 62)
    }
}
