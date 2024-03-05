//
//  AppShareData.swift
//  TicketSpark
//
//  Created by Apple on 29/02/24.
//

import Foundation
import UIKit

let window = (UIApplication.shared.delegate as! AppDelegate).window
let boundary = "Boundary-\(NSUUID().uuidString)"

class AppShareData {
    public static var shared = AppShareData()
    var appdelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    private init() {}
    
    // MARK: - Check User Login
    func IsUserAlreadyLogin(){
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData)
        print("Get data",userModel?.email ?? "")
        if userModel?.email != nil {
            //showOrganisation()
            setRootToDashboardVC()
        } else {
            showIntroScreen()
        }
    }
    
    func showOrganisation(){
        let sb = UIStoryboard(name: Storyboard.organization.rawValue, bundle: Bundle.main)
        let navController = sb.instantiateViewController(withIdentifier: "AddOrganizerNavigation") as? UINavigationController
        appdelegate.window?.rootViewController = navController
        appdelegate.window?.makeKeyAndVisible()
    }
    func showIntroScreen(){
        let sb = UIStoryboard(name: Storyboard.session.rawValue, bundle: Bundle.main)
        let  navController = sb.instantiateViewController(withIdentifier: "SessionNavigation") as? UINavigationController
        appdelegate.window?.rootViewController = navController
        appdelegate.window?.makeKeyAndVisible()
    }

    func setRootToDashboardVC(){
        let sb = UIStoryboard.init(name: Storyboard.addOrganizerTab.rawValue, bundle: nil)
//        guard let objHomeViewController = sb.instantiateViewController(withIdentifier: StoryboardIdentifier.DashboardTabBarController.rawValue) as? DashboardTabBarController else {
//            return
//        }
        
        let navController = sb.instantiateViewController(withIdentifier: "DashboardNavigation") as? UINavigationController
        navController?.isNavigationBarHidden = true
        appdelegate.window?.rootViewController = navController
        appdelegate.window?.makeKeyAndVisible()
    }
}
