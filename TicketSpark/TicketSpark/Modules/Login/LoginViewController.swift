//
//  LoginViewController.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//


//Check validation of txtOTP for btn Signin
import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblSignInTitle: UILabel!
    @IBOutlet weak var lblSignInSubTitle: UILabel!
    @IBOutlet weak var lblEmailView: UILabel!
    @IBOutlet weak var lblMobileView: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgRememberMe: UIImageView!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnJoinAdmissionStaff: UIButton!
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnMobileSendOTP: UIButton!
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgMobileNumber: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
    
    @IBOutlet weak var signInBtnTop: NSLayoutConstraint!
    
    // MARK: - VARIABLES
    let viewModel = LoginViewModel()
    var signInButtonEnabled = false {
        didSet {
            if signInButtonEnabled {
                self.btnSignIn.isEnabled = true
                self.btnSignIn.alpha = 1
            }  else {
                self.btnSignIn.isEnabled = false
                self.btnSignIn.alpha = 0.5
            }
        }
    }
    var isEmailViewSelected = true {
        didSet {
            if isEmailViewSelected {
                emailView.isHidden = false
                mobileView.isHidden = true
                self.imgEmail.image = UIImage(named: ImageConstants.Image.imgRadioSelected.value)
                self.imgMobileNumber.image = UIImage(named: ImageConstants.Image.imgRadioUnselected.value)
                self.signInBtnTop.constant = self.viewModel.emailSignInTop
            } else {
                emailView.isHidden = true
                mobileView.isHidden = false
                self.imgEmail.image = UIImage(named: ImageConstants.Image.imgRadioUnselected.value)
                self.imgMobileNumber.image = UIImage(named: ImageConstants.Image.imgRadioSelected.value)
                self.signInBtnTop.constant = self.viewModel.mobileSignInTop
            }
            self.validateFields()
        }
    }
    var isRememberMe = false {
        didSet {
            if isRememberMe {
                self.imgRememberMe.image = UIImage.init(named: ImageConstants.Image.imgCheckboxSelected.value)
            } else {
                self.imgRememberMe.image = UIImage.init(named: ImageConstants.Image.imgCheckboxUnselected.value)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        self.hideNavBarImage = false
    }
}
// MARK: - FUNCTIONS
extension LoginViewController {
    func initSetup() {
        self.setUpView()
        self.setFont()
        self.setUpAction()
        self.setUpCountryPicker()
        self.setText()
        self.setData()
    }
    
    func setText() {
        self.gogleSignInView.lblSeperator.text = "Or Sign in with"
        self.gogleSignInView.lblDontHaveAccount.text = "Don’t have an account?"
        self.gogleSignInView.btnSignIn.setTitle("Sign up", for: .normal)
        
        let _ = viewModel.countriesModel.contains { countryData in
            //if countryData.country_code == NSLocale.current.language.region?.identifier {
            if countryData.country_code == self.getCurrentLanguageIdentifier() {
                self.viewModel.strCountryDialCode = countryData.dial_code
                self.lblDialCountryCode.text = self.viewModel.strCountryDialCode
                return true
            }
            return false
        }
       self.setPicker(str: "", arr: nil)
    }
    
    func setData() {
        if UserDefaultManager.share.getUserBoolValue(key: .rememberMe) {
            if let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData) {
                self.isRememberMe = true
                self.txtEmail.text = userModel.email ?? ""
                self.txtPassword.text = userModel.password ?? ""
               // self.txtMobileNumber.text = userModel.number ?? ""
                self.txtMobileNumber.addDoneButtonOnKeyboard()
                // Defoult Country
                 // UI Changes---
                /*
//                self.imgCountry.image = nil
//                if self.imgCountry.image == nil {
//                    var str = ""
//                    var arr = viewModel.countriesModel.filter({$0.dial_code == str})
//
//                    if userModel.strDialCountryCode != nil && userModel.strDialCountryCode != ""{
//                        str = userModel.strDialCountryCode ?? ""
//                        arr = viewModel.countriesModel.filter({$0.dial_code == str})
//
//
//                        if !arr.indices.contains(0){
//                            //str = NSLocale.current.language.region?.identifier ?? ""
//                            str = self.getCurrentLanguageIdentifier() ?? ""
//                            arr = viewModel.countriesModel.filter({$0.country_code == str})
//                        }
//                    }else{
//                        //str = NSLocale.current.language.region?.identifier ?? ""
//                        str = self.getCurrentLanguageIdentifier() ?? ""
//                        arr = viewModel.countriesModel.filter({$0.country_code == str})
//                    }
//                    self.setPicker(str: str, arr: arr)
//
//                } else {
//                    // noting to do
//                }
                  */
                self.setPicker(str: "", arr: nil)
            }
            self.validateFields()
        } else {
            self.isRememberMe = false
        }
    }
    
    func setPicker(str:String, arr:[CountryInfo]? = nil) {
        var str = str
        var arr = arr
        if str == "" {
            self.imgCountry.image = nil
            arr = viewModel.countriesModel.filter({$0.dial_code == str})
            //str = NSLocale.current.language.region?.identifier ?? ""
            str = self.getCurrentLanguageIdentifier() ?? ""
            arr = viewModel.countriesModel.filter({$0.country_code == str})
            
        }
        let imagePath = "CountryPicker.bundle/\(str ).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.lblDialCountryCode.text = "+91"
 //       let arr = viewModel.countriesModel.filter({$0.country_code == str})
        
        if let arr = arr, arr.count>0 {
            let country = arr[0]
            self.viewModel.strCountryDialCode = country.dial_code
            self.lblDialCountryCode.text = country.dial_code
            self.viewModel.strCountryCode = country.country_code
            self.viewModel.strCountryName = country.country_name
            self.lblDialCountryCode.text = country.dial_code
            self.viewModel.strCountryCode = country.country_code
            let imagePath = "CountryPicker.bundle/\( country.country_code).png"
            self.imgCountry.image = UIImage(named: imagePath)
        }
    }
    
    func setUpCountryPicker() {
        self.viewModel.countries = self.jsonSerial()
        self.collectCountries()
    }
    
    func setUpView() {
        self.hideBackButton = true
        //[otpView.txtOtp1, otpView.txtOtp2, otpView.txtOtp3, otpView.txtOtp4].forEach({ $0?.delegate = self })
    }
    
    func setFont() {
        self.lblSignInTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSignInSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmailView.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        self.lblMobileView.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        self.lblEmail.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.lblPassword.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtEmail.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.txtPassword.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblForgotPassword.font = CustomFont.shared.bold(sizeOfFont: 12.0)
        self.btnSignIn.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 16.0)
        self.btnJoinAdmissionStaff.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
        
        self.lblMobileNumber.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        self.txtMobileNumber.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblDialCountryCode.font = CustomFont.shared.regular(sizeOfFont: 12.0)
    }
    
    func setUpAction() {
        self.signInButtonEnabled = false
        self.btnMobileSendOTP.isEnabled = false
        self.btnMobileSendOTP.alpha = 0.5
        self.otpView.btnResend.addTarget(self,action:#selector(resendOTPAction), for:.touchUpInside)
        self.gogleSignInView.btnSignIn.addTarget(self,action:#selector(signUpAction), for:.touchUpInside)
        self.txtMobileNumber.addTarget(self,action: #selector(textFieldChangedValue(_:)), for: .editingChanged)
        self.btnSignIn.addTarget(self,action: #selector(signInButtonalidation), for: .editingChanged)
        [txtEmail, txtPassword, txtMobileNumber, otpView.txtOtp1, otpView.txtOtp2, otpView.txtOtp3, otpView.txtOtp4].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.otpView.endTimeCallBack = {
            //self.signInBtnTop.constant -= 30.0
        }
        
        self.otpView.otpVerifyCallBack = {
            //self.otpVerify()
            let otp = "\(self.otpView.txtOtp1.text ?? "")" + "\(self.otpView.txtOtp2.text ?? "")" + "\(self.otpView.txtOtp3.text ?? "")" + "\(self.otpView.txtOtp4.text ?? "")"
            if self.otpView.txtOtp1.text ?? "" != "" && self.otpView.txtOtp2.text ?? "" != "" && self.otpView.txtOtp3.text ?? "" != "" && self.otpView.txtOtp4.text ?? "" != "" {
                self.viewModel.otp = otp
            } else {
                self.viewModel.otp = ""
            }
            self.validateFields()
        }
    }
    
    func validateFields() {
        if isEmailViewSelected {
            guard
                let email = txtEmail.text, !email.isEmpty,
                let password = txtPassword.text, !password.isEmpty
            else {
                self.signInButtonEnabled = false
                return
            }
            self.signInButtonEnabled = true
        } else {
            guard
                let mobileNumber = txtMobileNumber.text, !mobileNumber.isEmpty,
                !self.viewModel.otp.isEmpty
            else {
                self.signInButtonEnabled = false
                return
            }
            self.signInButtonEnabled = true
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        self.validateFields()
    }
    
    @objc func signInButtonalidation() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func textFieldChangedValue(_ sender: UITextField) {
        self.btnMobileSendOTP.isEnabled = sender.text!.count >= 10
        self.btnMobileSendOTP.alpha = (sender.text!.count >= 10) ? 1 : 0.5
    }
    
    @objc func resendOTPAction() {
        self.sendOTP()
    }
    
    
    @objc func signUpAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func signIn(){
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.signInAPI(self.txtEmail.text ?? "", self.txtPassword.text ?? "", self.txtMobileNumber.text ?? "", self.viewModel.strCountryDialCode, self.viewModel.otp, isEmailViewSelected: self.isEmailViewSelected) { isSuccess, loginData, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                    if var loginData = loginData {
                        DispatchQueue.main.async {
                            self.otpView.validateOTP(valid: true)
                            if let password = self.txtPassword.text {
                                loginData.password = password
                            }
                            UserDefaultManager.share.saveModelDataToUserDefults(userData: loginData, key: .userData)
                            self.navigateToOrganizer()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        if msg == StringConstants.Login.invalidOTP.value {
                            self.otpView.validateOTP(valid: false)
                            self.otpView.inValidateOTP()
                            self.otpView.endTimerForInvalidOTP()
                        }
                        self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                    }
                }
            }
        } else {
            self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
        }
    }
    
    func otpVerify() {
        let otp = "\(self.otpView.txtOtp1.text ?? "")" + "\(self.otpView.txtOtp2.text ?? "")" + "\(self.otpView.txtOtp3.text ?? "")" + "\(self.otpView.txtOtp4.text ?? "")"
        self.viewModel.otp = otp
        if self.otpView.txtOtp1.text ?? "" == "" || self.otpView.txtOtp2.text ?? "" == "" || self.otpView.txtOtp3.text ?? "" == "" || self.otpView.txtOtp4.text ?? "" == "" {
            self.showToast(with: StringConstants.Login.enterOTP.value, position: .top, type: .warning)
        } else {
            if Reachability.isConnectedToNetwork(){
                LoadingIndicatorView.show()
                
            } else {
                self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
            }
        }
    }
    
    func sendOTP() {
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.sendOTP(mobileNumber: self.txtMobileNumber.text ?? "", countryCode: self.viewModel.strCountryDialCode) { isSuccess, data, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                        DispatchQueue.main.async {
                            self.otpView.startTimer()
                            if self.viewModel.timerShown {
                                self.viewModel.timerShown = false
                                self.signInBtnTop.constant += 40.0
                            }
                            self.showToast(with: msg ?? "", position: .top, type: .success)
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
    
    func navigateToOrganizer() {
        let storyBoard = UIStoryboard.init(name: Storyboard.organization.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddOrganizerVC") as! AddOrganizerVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - ACTIONS
extension LoginViewController {
    @IBAction func emailButtonAction(_ sender: UIButton) {
        self.isEmailViewSelected = true
    }
    @IBAction func mobileButtonAction(_ sender: UIButton) {
        self.isEmailViewSelected = false
        
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let otp = "\(self.otpView.txtOtp1.text ?? "")" + "\(self.otpView.txtOtp2.text ?? "")" + "\(self.otpView.txtOtp3.text ?? "")" + "\(self.otpView.txtOtp4.text ?? "")"
        let isValidate = viewModel.validateLogin(self.txtEmail.text ?? "", self.txtPassword.text ?? "", self.txtMobileNumber.text ?? "", otp, self.isEmailViewSelected)
        if isValidate.1 {
            self.signIn()
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
               //self.showAlert(message: isValidate.0)
            }
        }
    }
    
    @IBAction func joinAdmissionStaffAction(_ sender: UIButton) {
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        self.isRememberMe = !self.isRememberMe
        UserDefaultManager.share.setUserBoolValue(value: isRememberMe, key: .rememberMe)
    }
    
    @IBAction func btnSendOTPAction(_ sender: UIButton) {
        self.sendOTP()
    }
    
    @IBAction func btnCountryCodePickerAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if let sb = self.storyboard?.instantiateViewController(withIdentifier: "RSCountryPickerController") as? RSCountryPickerController {
            sb.RScountryDelegate = self
            sb.strCheckCountry = self.viewModel.strCountryName
           // sb.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(sb, animated: false)
            //self.navigationController?.present(sb ?? UIViewController(), animated: true, completion: nil)
        }
       
    }
}
// MARK: - Country Code
extension LoginViewController: RSCountrySelectedDelegate, UITextFieldDelegate {
    func collectCountries() {
        for country in viewModel.countries {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            viewModel.countriesModel.append(CountryInfo(country_code:code, dial_code:dailcode, country_name:name))
        }
    }
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.viewModel.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.viewModel.strCountryCode = country.country_code
        self.viewModel.strCountryName = country.country_name
        self.txtMobileNumber.becomeFirstResponder()
    }
}
