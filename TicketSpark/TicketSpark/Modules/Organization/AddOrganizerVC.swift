//
//  AddOrganizerVC.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class AddOrganizerVC: BaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtOrganizationName: CustomTextFieldView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var countryDropDown: DropDownTextField!
    @IBOutlet weak var logoContentView: UIView!
    @IBOutlet weak var btnChangeLogo: UIButton!
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var btnNext: NextButton!
    @IBOutlet weak var stackOrganizationLogo: UIStackView!
    @IBOutlet weak var lblOrganzationLogo: UILabel!
    
    // MARK: - NEXT VIEW
    @IBOutlet weak var stackSocialFeedView: UIStackView!
    @IBOutlet weak var txtWebSiteView: CustomTextFieldView!
    @IBOutlet weak var txtFacebookPage: CustomTextFieldView!
    @IBOutlet weak var txtTwitter: CustomTextFieldView!
    @IBOutlet weak var txtLinkdin: CustomTextFieldView!
    @IBOutlet weak var lblSocialNetwork: UILabel!
    @IBOutlet weak var lblAboutOrganization: UILabel!
    
    // MARK: - Add organizer
    @IBOutlet weak var lblOrganizerDescription: UILabel!
    @IBOutlet weak var btnAddOrgaizer: UIButton!
    @IBOutlet weak var addOrgStackView: UIStackView!
    
    @IBOutlet weak var btnCountryPicker: UIButton!
    
    
    // MARK: - VARIABLES
    var viewModel = AddOrganizerViewModel()
    var hideBackBtn: Bool = true {
        didSet {
            if hideBackBtn {
                self.hideBackButton = true
            } else {
                self.hideBackButton = false
                self.configBackButton()
            }
        }
    }
    var isToHideSocialOrganizationView: Bool = false {
        didSet {
               btnNext.isHidden = false
//            UIView.animate(withDuration: 0.5,delay: 0.0,usingSpringWithDamping: 0.9,initialSpringVelocity: 1, options: [.curveEaseOut],animations: {
                self.stackSocialFeedView.layoutIfNeeded()
                if self.isToHideSocialOrganizationView {
                    self.stackOrganizationLogo.alpha = 1
                    self.stackSocialFeedView.alpha = 0
                    self.stackOrganizationLogo.isHidden = false
                    self.stackSocialFeedView.isHidden = true
                    self.btnNext.title = StringConstants.AddOrganizer.next.value
                    lblAboutOrganization.isHidden = false
                    self.hideBackBtn = true
                    self.btnCountryPicker.isHidden = false
                   // btnCountryPicker.isHidden = true
                } else {
                    self.stackOrganizationLogo.alpha = 0
                    self.stackSocialFeedView.alpha = 1
                    self.stackOrganizationLogo.isHidden = true
                    self.stackSocialFeedView.isHidden = false
                    self.btnNext.title = StringConstants.AddOrganizer.saveAndNext.value
                    lblAboutOrganization.isHidden = false
                    self.hideBackBtn = false
                    self.btnCountryPicker.isHidden = true
                   // btnCountryPicker.isHidden = false
                   // self.configBackButton()
                }
//            },
//            completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setFont()
        btnNext.actionSubmit = { [weak self] _ in
            if let self {
                //self.isToHideSocialOrganizationView = !self.isToHideSocialOrganizationView
                if self.isToHideSocialOrganizationView {
                    self.apiCallForAddOrganization()
                } else {
                    self.hideBackBtn = false
                    self.apiCallForOrganizationInfo()
                }
            }
        }
    }
    
    override func popBack() {
        self.isToHideSocialOrganizationView = true
    }

    func setUI() {
        self.addNavBarImage()
        self.hideBackBtn = true
        stackOrganizationLogo.isHidden = true
        lblAboutOrganization.isHidden = true
        btnNext.isHidden = true
        stackSocialFeedView.isHidden = true
        txtWebSiteView.lbl.text = StringConstants.AddOrganizer.website.value
        txtFacebookPage.lbl.text = StringConstants.AddOrganizer.facebookPage.value
        txtTwitter.lbl.text = StringConstants.AddOrganizer.twitter.value
        txtLinkdin.lbl.text = StringConstants.AddOrganizer.linkdin.value
        btnAddOrgaizer.layer.cornerRadius = btnAddOrgaizer.frame.height/2
        imgViewLogo.setTextFiledBorder()
        logoContentView.setTextFiledBorder()
        countryDropDown.setTextFiledBorder()
        txtOrganizationName.lbl.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblCountry.font = CustomFont.shared.medium(sizeOfFont: 14)
        lblOrganzationLogo.font = CustomFont.shared.medium(sizeOfFont: 14)
        countryDropDown.placeholder = StringConstants.AddOrganizer.selectCountry.value
        countryDropDown.arrowImage = UIImage(systemName: "imgDropDown")
        countryDropDown.isSearchEnable = false
       // countryDropDown.optionArray = ["India", "Australia", "New Zealand", "Nepal", "Bhutan"]
        btnChangeLogo.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14)
        btnChangeLogo.titleLabel?.tintColor = .grayTextColor
        countryDropDown.font = CustomFont.shared.regular(sizeOfFont: 14)
        lblAboutOrganization.font = CustomFont.shared.bold(sizeOfFont: 18)
        lblAboutOrganization.text = StringConstants.AddOrganizer.aboutOrganization.value
        lblAboutOrganization.textColor = .appBlackTextColor
        lblSocialNetwork.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblSocialNetwork.textColor = .appBlackTextColor
        txtOrganizationName.lbl.attributedText = StringConstants.AddOrganizer.organizationName.value.addAttributedString(highlightedString: "*")
        btnChangeLogo.addTarget(self, action:#selector(changeImage), for: .touchUpInside)
      //  countryDropDown.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: openCountryPicker()))
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.bold(sizeOfFont: 18.0)
        self.lblAboutOrganization.font = CustomFont.shared.bold(sizeOfFont: 18.0)
        self.lblCountry.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.lblOrganzationLogo.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.lblOrganizerDescription.font = CustomFont.shared.regular(sizeOfFont: 18.0)
        self.btnAddOrgaizer.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 16.0)
        self.btnChangeLogo.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14.0)
    }
    
    @objc func changeImage() {
        ImagePickerManager().pickImage(self) {image in
            self.imgViewLogo.image = image
            //ImagePickerManager().openGallery(viewController: self)
        }
    }
    
     func openCountryPicker() {
        self.view.endEditing(true)
         self.viewModel.countriesModel = self.viewModel.countriesModel.removeDuplicates()
        let storyBoard = UIStoryboard(name: Storyboard.session.rawValue, bundle: nil)
        if let sb = storyBoard.instantiateViewController(withIdentifier: "RSCountryPickerController") as? RSCountryPickerController {
            sb.RScountryDelegate = self
            sb.RScountriesModel = self.viewModel.countriesModel
            sb.isFromOrganization = true
            //sb.strCheckCountry = self.viewModel.strCountryName
            self.navigationController?.pushViewController(sb, animated: false)
        }
    }
    
    
    func apiCallForAddOrganization(){
        let imgData = self.imgViewLogo.image?.jpegData(compressionQuality: 0.8)
        let isValidate = self.viewModel.validate(self.txtOrganizationName.txtFld.text ?? "", countryDropDown.text ?? "", imgData)
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.createOrganization(name: self.txtOrganizationName.txtFld.text ?? "", organizationLogo: UIImage(named: ImageConstants.Image.imgEyeHide.value)!, countryId: self.viewModel.selectedCountry?.id ?? 0) { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if let response = response {
                            self.viewModel.organizerData = response
                            DispatchQueue.main.async {
                               // self.hideBackBtn = false
                               // self.configBackButton()
                                self.addOrgStackView.isHidden = true
                                self.isToHideSocialOrganizationView = !self.isToHideSocialOrganizationView
                                //self.isToHideSocialOrganizationView = true
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
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
               //self.showAlert(message: isValidate.0)
            }
        }
    }
    
    func apiCallForOrganizationInfo(){
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.updateOrganizationInfo(organizationId: self.viewModel.organizerData?.id ?? 0, websiteURL: self.txtWebSiteView.txtFld.text ?? "", facebookURL: self.txtFacebookPage.txtFld.text ?? "", twitterURL: self.txtTwitter.txtFld.text ?? "", linkedinURL: self.txtLinkdin.txtFld.text ?? "") { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if let response = response {
                            DispatchQueue.main.async {
                                //MOVE TO NEXT VIEW
                                self.showToast(with: msg ?? "success", position: .top, type: .success)
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
    
    func apiCallForGetAllCountry(){
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.getCountryList() { isSuccess, response, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if let response = response {
                            response.forEach { data in
                                self.viewModel.countriesModel.append(CountryInfo(country_code: data.countryCode ?? "", dial_code: "", country_name: data.countryName ?? "", id: data.id ?? 0))
                            }
                            DispatchQueue.main.async {
                                self.openCountryPicker()
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
    
    @IBAction func actionAddOrganizer(_ sender: UIButton) {
        addOrgStackView.isHidden = true
        self.isToHideSocialOrganizationView = true
    }
    
    @IBAction func btnCountryPicketAction(_ sender: UIButton) {
        self.apiCallForGetAllCountry()
    }
    
}
// MARK: - Country Code
extension AddOrganizerVC: RSCountrySelectedDelegate, UITextFieldDelegate {
    func RScountrySelected(countrySelected country: CountryInfo) {
        self.viewModel.selectedCountry = country
        self.countryDropDown.text = country.country_name
    }
}
