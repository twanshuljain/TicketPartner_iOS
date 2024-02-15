//
//  AddOrganizerVC.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class AddOrganizerVC: UIViewController {
    @IBOutlet weak var txtOrganizationName: CustomTextFieldView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var countryDropDown: DropDownTextField!
    @IBOutlet weak var logoContentView: UIView!
    @IBOutlet weak var btnChangeLogo: UIButton!
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var btnNext: NextButton!
    @IBOutlet weak var stackOrganizationLogo: UIStackView!
    // MARK: - NEXT VIEW
    @IBOutlet weak var stackSocialFeedView: UIStackView!
    @IBOutlet weak var txtWebSiteView: CustomTextFieldView!
    @IBOutlet weak var txtFacebookPage: CustomTextFieldView!
    @IBOutlet weak var txtTwitter: CustomTextFieldView!
    @IBOutlet weak var txtLinkdin: CustomTextFieldView!
    @IBOutlet weak var lblSocialNetwork: UILabel!
    
    
    var isToHideSocialOrganizationView: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.stackOrganizationLogo.isHidden = !self.isToHideSocialOrganizationView
                self.stackSocialFeedView.isHidden = self.isToHideSocialOrganizationView
            }
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
        // Do any additional setup after loading the view.
    }

    func setUI() {
        txtWebSiteView.lbl.text = "Website"
        txtFacebookPage.lbl.text = "Facebook Page"
        txtTwitter.lbl.text = "Twitter"
        txtLinkdin.lbl.text = "LinkdIn"
        
        imgViewLogo.setTextFiledBorder()
        logoContentView.setTextFiledBorder()
        countryDropDown.setTextFiledBorder()
    }
}
