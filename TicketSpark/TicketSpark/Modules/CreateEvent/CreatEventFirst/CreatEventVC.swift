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
    
    
    // MARK: - Variables
    var delegate : RichTextEditiorDelegate?
    var richTextString : String = ""
    var htmlCallbackState : Bool = false
    var editedText : String = ""
    let viewModel = CreatEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
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
        let txtBorders = [txtDrpEventType, txtDrpTimeZone, viewStartDate, viewStartTime, viewEndDate, viewEndTime, viewDoorStartDate, viewDoorStartTime, viewDoorEndDate, viewDoorEndTime, txtDrpState, txtDrpCountry]
        for txtBorder in txtBorders {
            txtBorder?.setTextFiledBorder()
        }
        let lbls = [lblEventType, lblDescribeEvent, lblEventCover, lblAddMoreImageEvent, lblAddMoreImagePastMedia, lblMediaFromPast, lblDoorOpenAt, lblEventStartEnd, lblTimeZone, lblState, lblCountry]
        for lbl in lbls {
            lbl?.font = CustomFont.shared.medium(sizeOfFont: 14)
            lbl?.textColor = .appBlackTextColor
        }
        lblDisplayEndTime.font = CustomFont.shared.medium(sizeOfFont: 16)
        lblDateTime.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblLocation.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        txtDrpEventType.font = CustomFont.shared.regular(sizeOfFont: 16)
        txtDrpEventType.placeholder = StringConstants.CreateEvent.selectEventType.value
        txtDrpEventType.optionArray = ["Hardy Sandu", "KK", "AR Rehman", "Arjit singh"]
        let text = StringConstants.CreateEvent.eventName.value + "*"
        txtEventTitle.lbl.attributedText = text.addAttributedString(highlightedString: "*")
        txtStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        txtEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        txtDoorEndDate.placeholder = StringConstants.CreateEvent.endDate.value
        txtDoorEndTime.placeholder = StringConstants.CreateEvent.endTime.value
        txtDoorStartDate.placeholder = StringConstants.CreateEvent.startDate.value
        txtDoorStartTime.placeholder = StringConstants.CreateEvent.startTime.value
        let txtDates = [txtStartDate, txtStartTime, txtEndDate, txtEndTime, txtDoorEndDate, txtDoorEndTime, txtDoorStartDate, txtDoorStartTime]
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
        txtDoorEndDate.editingBegin = {
            self.closeEndDateCenterCons.constant = 10
        }
        txtDoorEndTime.editingBegin = {
            self.closeEndTimeCenterCons.constant = 10
        }
        txtDoorStartDate.editingBegin = {
            self.closeStartDateCenterCons.constant = 10
        }
        txtDoorStartTime.editingBegin = {
            self.closeStartTimeCenterCons.constant = 10
        }
        txtLocationName.lbl.attributedText = StringConstants.CreateEvent.locationName.value.addAttributedString(highlightedString: "*")
        txtLocationName.txtFld.placeholder = StringConstants.CreateEvent.enterLocation.value
        
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
//        let _ = self.imgViewLogo.image?.jpegData(compressionQuality: 0.8)
//        let isValidate = self.viewModel.validate(self.txtOrganizationName.txtFld.text ?? "", countryDropDown.text ?? "", self.imgViewLogo.image)
//        if isValidate.1 {
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
//        } else {
//            DispatchQueue.main.async {
//                self.showToast(with: isValidate.0, position: .top, type: .warning)
//               //self.showAlert(message: isValidate.0)
//            }
//        }
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
