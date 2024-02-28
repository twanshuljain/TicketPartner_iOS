//
//  CreateAccountViewController.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import UIKit

class CreateAccountViewController: BaseViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnEmailVerify: UIButton!
    @IBOutlet weak var otpEmailView: OTPView!
    @IBOutlet weak var imgEmailVerified: UIImageView!
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnMobileVerify: UIButton!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
    @IBOutlet weak var imgeMobileVerified: UIImageView!
    @IBOutlet weak var btnCountryPicker: UIButton!
    
    @IBOutlet weak var otpMobileView: OTPView!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    @IBOutlet weak var gogleSignInView: GoogleSignInView!
    
    @IBOutlet weak var btnEyePassword: UIButton!
   // @IBOutlet weak var popOverView: PopOverView!
    
    // MARK: - VARIABLES
    let popOverView = PopOverView()
    let window = UIApplication.shared.keyWindow!
    let viewModel = CreateAccountViewModel()
    var verifyEmailBtnEnabled = false {
        didSet {
            if verifyEmailBtnEnabled {
                self.btnEmailVerify.isEnabled = true
                self.btnEmailVerify.alpha = 1
            }  else {
                self.btnEmailVerify.isEnabled = false
                self.btnEmailVerify.alpha = 0.5
            }
        }
    }
    var verifyMobileBtnEnabled = false {
        didSet {
            if verifyMobileBtnEnabled {
                self.btnMobileVerify.isEnabled = true
                self.btnMobileVerify.alpha = 1
            }  else {
                self.btnMobileVerify.isEnabled = false
                self.btnMobileVerify.alpha = 0.5
            }
        }
    }
    var createAccountBtnEnabled = false {
        didSet {
            if createAccountBtnEnabled {
                self.btnCreateAccount.isEnabled = true
                self.btnCreateAccount.alpha = 1
            }  else {
                self.btnCreateAccount.isEnabled = false
                self.btnCreateAccount.alpha = 0.5
            }
        }
    }
    
    var emailVerified = false {
        didSet {
            if emailVerified {
                self.otpEmailView.isHidden = true
                self.btnEmailVerify.isHidden = true
                self.imgEmailVerified.isHidden = false
                self.txtEmail.isUserInteractionEnabled = false
            }  else {
                self.otpEmailView.isHidden = false
                self.btnEmailVerify.isHidden = false
                self.imgEmailVerified.isHidden = true
                self.txtEmail.isUserInteractionEnabled = true
            }
        }
    }
    var mobileVerified = false {
        didSet {
            if mobileVerified {
                self.otpMobileView.isHidden = true
                self.btnMobileVerify.isHidden = true
                self.imgeMobileVerified.isHidden = false
                self.txtMobileNumber.isUserInteractionEnabled = false
                self.btnCountryPicker.isUserInteractionEnabled = false
            }  else {
                self.otpMobileView.isHidden = false
                self.btnMobileVerify.isHidden = false
                self.imgeMobileVerified.isHidden = true
                self.txtMobileNumber.isUserInteractionEnabled = true
                self.btnCountryPicker.isUserInteractionEnabled = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        self.hideNavBarImage = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addPopOverView()
        self.popOverView.isHidden = true
    }

}
// MARK: - FUNCTIONS
extension CreateAccountViewController {
    func initSetup() {
        self.setUpView()
        self.setFont()
        self.setUpAction()
        self.setText()
        self.setUpCountryPicker()
        self.setData()
    }
    
    func addPopOverView() {
        window.removePopOverView
        window.addSubview(self.popOverView)
        self.popOverView.frame = window.bounds
    }
    
    func setText() {
        self.gogleSignInView.lblSeperator.text = "Or Sign up with"
        self.gogleSignInView.lblDontHaveAccount.text = "Already have an account?"
        self.gogleSignInView.btnSignIn.setTitle("Sign in", for: .normal)
    }
    
    func setUpView() {
        self.mobileVerified = false
        self.emailVerified = false
        self.txtPassword.isSecureTextEntry = true
        self.otpEmailView.isHidden = !self.otpEmailView.isHidden
        self.otpMobileView.isHidden = !self.otpMobileView.isHidden
        self.hideBackButton = true
        self.popOverView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.popOverView.lblMsg.text = "Congratulations! Your account has been created successfully."
    }
    
    func setFont() {
        self.lblTitle.font = CustomFont.shared.bold(sizeOfFont: 24.0)
        self.lblSubTitle.font = CustomFont.shared.regular(sizeOfFont: 16.0)
        self.lblEmail.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtEmail.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnEmailVerify.titleLabel?.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        
        
        self.lblFirstName.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtFirstName.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.lblLastName.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtLastName.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        
        self.txtMobileNumber.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnMobileVerify.titleLabel?.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.lblDialCountryCode.font = CustomFont.shared.regular(sizeOfFont: 12.0)
        
        self.lblPassword.font = CustomFont.shared.medium(sizeOfFont: 12.0)
        self.txtPassword.font = CustomFont.shared.medium(sizeOfFont: 14.0)
        self.btnCreateAccount.titleLabel?.font = CustomFont.shared.bold(sizeOfFont: 14.0)
    }
    
    func setUpAction() {
        self.otpEmailView.otpVerifyCallBack = {
            self.otpVerify()
        }
        
        self.otpMobileView.otpVerifyCallBack = {
            self.otpVerify()
        }
        self.popOverView.btnPop.addTarget(self,action:#selector(popOverViewAction), for:.touchUpInside)
        self.gogleSignInView.btnSignIn.addTarget(self,action:#selector(signInAction), for:.touchUpInside)
        txtEmail.addTarget(self, action: #selector(editingChangedEmail), for: .editingChanged)
        txtMobileNumber.addTarget(self, action: #selector(editingChangedMobile), for: .editingChanged)
        [txtEmail, txtFirstName, txtLastName, txtPassword, txtMobileNumber].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    
    @objc func signInAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    @objc func popOverViewAction() {
        self.navigationController?.viewControllers.forEach({ vc in
            if vc is LoginViewController {
                self.popOverView.isHidden = !self.popOverView.isHidden
                self.navigationController?.popToViewController(vc as! LoginViewController, animated: false)
            }
        })
    }
    
    func setUpCountryPicker() {
        self.viewModel.countries = self.jsonSerial()
        self.collectCountries()
    }
    
    func setData() {
        self.txtEmail.text = self.viewModel.signUpRequest?.email ?? ""
        self.txtMobileNumber.addDoneButtonOnKeyboard()
        self.imgCountry.image = nil
        var str = ""
        var arr = viewModel.countriesModel.filter({$0.dial_code == str})
        
        //str = NSLocale.current.language.region?.identifier ?? ""
        str = self.getCurrentLanguageIdentifier() ?? ""
        arr = viewModel.countriesModel.filter({$0.country_code == str})
        
        let imagePath = "CountryPicker.bundle/\(str ).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.lblDialCountryCode.text = "+91"
        
        if arr.count>0 {
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
        self.validateFields()
        self.validateEmail()
        self.validateMobile()
    }
    
    func validateFields() {
            guard
                let email = txtEmail.text, !email.isEmpty,
                self.emailVerified,
                let fName = txtFirstName.text, !fName.isEmpty,
                let lName = txtLastName.text, !lName.isEmpty,
                let mobileNumber = txtMobileNumber.text, !mobileNumber.isEmpty,
                self.mobileVerified,
                let password = txtPassword.text, !password.isEmpty
            else {
                self.createAccountBtnEnabled = false
                return
            }
            self.createAccountBtnEnabled = true
    }
    
    func validateEmail() {
            guard
                let email = txtEmail.text, !email.isEmpty
            else {
                self.verifyEmailBtnEnabled = false
                return
            }
            self.verifyEmailBtnEnabled = true
    }
    
    func validateMobile() {
            guard
                let mobileNumber = txtMobileNumber.text, !mobileNumber.isEmpty
            else {
                self.verifyMobileBtnEnabled = false
                return
            }
            self.verifyMobileBtnEnabled = true
    }
    
    func sendOTPForMobile() {
        let isValidate = self.viewModel.validateMobile(self.txtMobileNumber.text ?? "")
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.sendMobileOTP(mobileNumber: self.txtMobileNumber.text ?? "", countryCode: self.viewModel.strCountryDialCode) { isSuccess, data, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                            DispatchQueue.main.async {
                                self.otpMobileView.isHidden = false
                                self.otpMobileView.startTimer()
                                self.viewModel.otpVerify = .number
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
            
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
            }
        }
    }
    
    func sendOTPForEmail() {
        let isValidate = self.viewModel.validateEmail(self.txtEmail.text ?? "")
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.sendEmailOTP(email: self.txtEmail.text ?? "") { isSuccess, data, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                            DispatchQueue.main.async {
                                self.otpEmailView.isHidden = false
                                self.otpEmailView.startTimer()
                                self.viewModel.otpVerify = .email
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
        } else {
            DispatchQueue.main.async {
                self.showToast(with: isValidate.0, position: .top, type: .warning)
            }
        }
    }
    
    func otpVerifyForEmail(otp: String) {
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.verifyEmailOTP(email: self.txtEmail.text ?? "", otp: otp) { isSuccess, data, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                        DispatchQueue.main.async {
                            // EMAIL OTP VERIFIED
                            self.setViewForVerified()
                            self.otpEmailView.validateOTP(valid: true)
                            self.showToast(with: msg ?? "", position: .top, type: .success)
                        }
                } else {
                    DispatchQueue.main.async {
                        self.otpEmailView.validateOTP(valid: false)
                        self.otpEmailView.inValidateOTP()
                        self.otpEmailView.endTimerForInvalidOTP()
                        self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                    }
                }
            }
        } else {
            self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
        }
    }
    
    func setViewForVerified() {
        if self.viewModel.otpVerify == .email {
            self.emailVerified = true
            self.validateFields()
        } else {
            self.mobileVerified = true
            self.validateFields()
        }
    }
    
    func otpVerifyForMobile(otp: String) {
        if Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.show()
            self.viewModel.verifyMobileOTP(mobileNumber: self.txtMobileNumber.text ?? "", countryCode: self.viewModel.strCountryDialCode, otp: otp) { isSuccess, data, msg in
                DispatchQueue.main.async {
                    LoadingIndicatorView.hide()
                }
                if isSuccess {
                        DispatchQueue.main.async {
                            // MOBILE OTP VERIFIED
                            self.setViewForVerified()
                            self.showToast(with: msg ?? "", position: .top, type: .success)
                            self.otpMobileView.validateOTP(valid: true)
                        }
                } else {
                    DispatchQueue.main.async {
                        self.otpMobileView.validateOTP(valid: false)
                        self.otpMobileView.inValidateOTP()
                        self.otpMobileView.endTimerForInvalidOTP()
                        self.showToast(with: msg ?? "No response from server", position: .top, type: .warning)
                    }
                }
            }
        } else {
            self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
        }
    }
    
    func otpVerify() {
        if self.viewModel.otpVerify == .email {
            let otp = "\(self.otpEmailView.txtOtp1.text ?? "")" + "\(self.otpEmailView.txtOtp2.text ?? "")" + "\(self.otpEmailView.txtOtp3.text ?? "")" + "\(self.otpEmailView.txtOtp4.text ?? "")"
            if self.otpEmailView.txtOtp1.text ?? "" == "" || self.otpEmailView.txtOtp2.text ?? "" == "" || self.otpEmailView.txtOtp3.text ?? "" == "" || self.otpEmailView.txtOtp4.text ?? "" == "" {
                //self.showToast(with: StringConstants.Login.enterOTP.value, position: .top, type: .warning)
            } else {
                if Reachability.isConnectedToNetwork(){
                    LoadingIndicatorView.show()
                    self.otpVerifyForEmail(otp: otp)
                } else {
                    self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
                }
            }
        } else {
            let otp = "\(self.otpMobileView.txtOtp1.text ?? "")" + "\(self.otpMobileView.txtOtp2.text ?? "")" + "\(self.otpMobileView.txtOtp3.text ?? "")" + "\(self.otpMobileView.txtOtp4.text ?? "")"
            if self.otpMobileView.txtOtp1.text ?? "" == "" || self.otpMobileView.txtOtp2.text ?? "" == "" || self.otpMobileView.txtOtp3.text ?? "" == "" || self.otpMobileView.txtOtp4.text ?? "" == "" {
            } else {
                if Reachability.isConnectedToNetwork(){
                    LoadingIndicatorView.show()
                    self.otpVerifyForMobile(otp: otp)
                } else {
                    self.showToast(with: ValidationConstantStrings.networkLost, position: .top, type: .warning)
                }
            }
        }
    }
    
    
    @objc func editingChangedEmail(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        self.validateEmail()
    }
    
    @objc func editingChangedMobile(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        self.validateMobile()
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
    
    func signUp(){
        let isValidate = self.viewModel.validateSignUp(self.txtFirstName.text ?? "", lName: self.txtLastName.text ?? "", self.txtEmail.text ?? "", self.txtPassword.text ?? "", self.txtMobileNumber.text ?? "", self.viewModel.strCountryDialCode)
        if isValidate.1 {
            if Reachability.isConnectedToNetwork() {
                LoadingIndicatorView.show()
                self.viewModel.signUpAPI(self.txtFirstName.text ?? "", self.txtLastName.text ?? "", self.txtEmail.text ?? "", self.txtPassword.text ?? "", self.txtMobileNumber.text ?? "", self.viewModel.strCountryDialCode) { isSuccess, signUpData, msg in
                    DispatchQueue.main.async {
                        LoadingIndicatorView.hide()
                    }
                    if isSuccess {
                        if var signUpData = signUpData {
                            DispatchQueue.main.async {
                                self.popOverView.isHidden = !self.popOverView.isHidden
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
}

// MARK: - ACTIONS
extension CreateAccountViewController {
    
    @IBAction func btnEmailVerifyAction(_ sender : UIButton) {
       // self.viewModel.signUpRequest?.email = self.txtEmail.text ?? ""
        self.sendOTPForEmail()
    }
    
    @IBAction func btnMobileVerifyAction(_ sender : UIButton) {
        self.sendOTPForMobile()
    }
    
    @IBAction func btnCreateAccount(_ sender : UIButton) {
        self.signUp()
    }
    
    @IBAction func btnCountryCodePickerAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if let sb = self.storyboard?.instantiateViewController(withIdentifier: "RSCountryPickerController") as? RSCountryPickerController {
            sb.RScountryDelegate = self
            sb.strCheckCountry = self.viewModel.strCountryName
            self.navigationController?.pushViewController(sb, animated: false)
        }
       
    }
    
    @IBAction func btnPasswordEyeAction(_ sender: UIButton) {
        if self.txtPassword.isSecureTextEntry == false {
            self.btnEyePassword.setImage(UIImage(named: ImageConstants.Image.imgEyeHide.value), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        } else {
            self.btnEyePassword.setImage(UIImage(named: ImageConstants.Image.imgEyeOpen.value), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    
}
// MARK: - Country Code
extension CreateAccountViewController: RSCountrySelectedDelegate, UITextFieldDelegate {
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
