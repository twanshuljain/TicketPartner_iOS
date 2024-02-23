//
//  AddOrganizerVC.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class AddOrganizerVC: BaseViewController {
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
    
    var isToHideSocialOrganizationView: Bool = false {
        didSet {
               btnNext.isHidden = false
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: [.curveEaseOut],
                           animations: {
                self.stackSocialFeedView.layoutIfNeeded()
                if self.isToHideSocialOrganizationView {
                    self.stackOrganizationLogo.alpha = 1
                    self.stackSocialFeedView.alpha = 0
                    self.stackOrganizationLogo.isHidden = false
                    self.stackSocialFeedView.isHidden = true
                } else {
                    self.stackOrganizationLogo.alpha = 0
                    self.stackSocialFeedView.alpha = 1
                    self.stackOrganizationLogo.isHidden = true
                    self.stackSocialFeedView.isHidden = false
                    self.btnNext.title = StringConstants.AddOrganizer.saveAndNext.value
                }
            },
            completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        btnNext.actionSubmit = { [weak self] _ in
            if let self {
                self.isToHideSocialOrganizationView = !self.isToHideSocialOrganizationView
            }
        }
    }

    func setUI() {
        self.hideNavigationBar = false
        self.title = "Add Organization"
        self.hideBackButton = true
        stackOrganizationLogo.isHidden = true
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
        countryDropDown.arrowImage = UIImage(systemName: "chevron.down")
        countryDropDown.isSearchEnable = false
        countryDropDown.optionArray = ["India", "Australia", "New Zealand", "Nepal", "Bhutan"]
        btnChangeLogo.titleLabel?.font = CustomFont.shared.regular(sizeOfFont: 14)
        btnChangeLogo.titleLabel?.tintColor = .grayTextColor
        countryDropDown.font = CustomFont.shared.regular(sizeOfFont: 14)
        lblAboutOrganization.font = CustomFont.shared.bold(sizeOfFont: 18)
        lblAboutOrganization.text = StringConstants.AddOrganizer.aboutOrganization.value
        lblAboutOrganization.textColor = .appBlackTextColor
        lblSocialNetwork.font = CustomFont.shared.semiBold(sizeOfFont: 18)
        lblSocialNetwork.textColor = .appBlackTextColor
        txtOrganizationName.lbl.attributedText = StringConstants.AddOrganizer.organizationName.value.addAttributedString(highlightedString: "*")
    
    }
    
    @IBAction func actionAddOrganizer(_ sender: UIButton) {
        addOrgStackView.isHidden = true
        self.isToHideSocialOrganizationView = true
    }
    
}
