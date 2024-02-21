//
//  BaseViewController.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    var backButton:UIButton {
        let button = UIButton(frame: CGRect(x: -10, y: 0, width: 30, height: 30))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        button.setImage(UIImage(named:"imgBack"), for: .normal)
        button.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        return button
    }
    
    var blackBackButton:UIButton {
        let button = UIButton(frame: CGRect(x: -10, y: 0, width: 40, height: 40))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -20, bottom: 0, right: 0)
        button.setImage(UIImage(named:"imgBlackBack"), for: .normal)
        button.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        return button
    }

    
    var settingButton:UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(named:"ic_white_setting"), for: .normal)
        button.addTarget(self, action: #selector(showSetting), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }
    
    
    var logoutButton:UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.setImage(UIImage(named:"ic_log_out"), for: .normal)
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }
    
    var doneButton:UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Gilroy-Bold", size: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }

    var plusButton:UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(named:"ic_white_plus"), for: .normal)
        button.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }

    
    var editButton:UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(named:"ic_white_edit"), for: .normal)
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }

//    var notificationButton:BadgeButton {
//
//        let badgeButton = BadgeButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
////        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        badgeButton.setImage(UIImage(named:"ic_home_bell"), for: .normal)
//        if let count = userDefault.value(forKey: UserDefaults.Keys.USER_UNREAD_COUNT) as? Int{
//            if count == 0{
//                badgeButton.badge = nil
//            }else{
//                badgeButton.badge = "\(count)"
//            }
//        }else {
//            badgeButton.badge = nil
//        }
//
//        badgeButton.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
//        return badgeButton
//    }
    
    var hideBackButton = false {
        didSet {
            if hideBackButton{
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            }
            self.navigationItem.setHidesBackButton(hideBackButton, animated: false)
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    var hideNavigationBar = false {
        
        didSet {
            
            if hideNavigationBar {
                self.navigationItem.setHidesBackButton(true, animated: false)
                self.navigationItem.leftBarButtonItem = nil
            } else {
                self.navigationItem.setHidesBackButton(false, animated: false)
            }
        }
    }
    
    var hideNavBarImage = false {
        didSet {
            if hideNavigationBar {
                
            } else {
                self.addNavBarImage()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSetup()
        // Do any additional setup after loading the view.
    }
    
    func configCallNavBar(){
        
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil


       // self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: 18.0)!, NSAttributedString.Key.foregroundColor:UIColor.black]
        
        self.navigationController?.navigationBar.barTintColor = .white //THEME_COLOR.appCallBlackColor
        self.navigationController?.navigationBar.isTranslucent = false
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    func configVideoCallNavBar(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = nil
      //  self.navigationController?.navigationBar.barTintColor = .clear
    }
    
    func setNavBar() {
        let image = UIImage(named: ImageConstants.Image.imgNavStar.value)
        let navLabel = UILabel()
        let string = "MyTicketPartner" as NSString

        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18.0)])

        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        let normalFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        let labelColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // Part of string to be bold
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "My"))
        attributedString.addAttributes(normalFontAttribute, range: string.range(of: "Ticket"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Partner"))
        
        attributedString.addAttributes(labelColorAttribute, range: string.range(of: "MyTicketPartner"))

        // 4
        navLabel.attributedText = attributedString
        navLabel.tintColor = UIColor.white
        
        let imageView = UIImageView(image: image)
        let titleView = UIStackView(arrangedSubviews: [imageView, navLabel])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
    
    func addNavBarImage() {
            let navController = navigationController!
        let image = UIImage(named: ImageConstants.Image.imgLogo.value)
            let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width - 20.0
        let bannerHeight = navController.navigationBar.frame.size.height - 20.0
            let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
            let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            navigationItem.titleView = imageView
        }

    
    func configProfileNavBar(){
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil


        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: 18.0)!,NSAttributedString.Key.foregroundColor:UIColor.black]
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        let backBarButton = UIBarButtonItem(customView: blackBackButton)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    func configBackButton() {
        self.navigationController?.navigationBar.isTranslucent = false
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    func openLink(urlString: String){
        if let url = NSURL(string: "http://\(urlString)"){
            if #available(iOS 10, *){
                UIApplication.shared.open(url as URL)
            }else{
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    fileprivate func initSetup () {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:CustomFont.shared.semiBold(sizeOfFont: 18.0), NSAttributedString.Key.foregroundColor:UIColor.black]
       // self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: 20.0)!, NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .white //THEME_COLOR.appBlueColor
        self.navigationController?.navigationBar.isTranslucent = true
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.hideNavigationBar = false
        self.navigationItem.leftBarButtonItem = backBarButton
        //self.setNavBar()
      // self.addNavBarImage()
    }
    
    @objc func popBack () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showSetting () {
        
    }
    
    @objc func logoutAction () {
        
    }

    @objc func doneAction () {
        
    }
    
    @objc func plusAction () {
        
    }

    
    @objc func editAction () {
        
    }

    
    @objc func showNotifications () {
    }
}
