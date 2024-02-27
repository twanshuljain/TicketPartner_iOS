//
//  AppDelegate.swift
//  TicketSpark
//
//  Created by Apple on 06/02/24.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = AppDelegate()
    
    private override init() { }
    var window: UIWindow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //window.rootViewController = UIStoryboard(name: "Session", bundle: nil).instantiateInitialViewController()
       // window.makeKeyAndVisible()
        self.IsUserAlreadyLogin()
        
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TicketSpark")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Check User Login
    func IsUserAlreadyLogin(){
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData)
        print("Get data",userModel?.email ?? "")
        if userModel?.email != nil {
            showOrganisation()
        } else {
            showIntroScreen()
        }
    }
    
    func  showOrganisation(){
        let sb = UIStoryboard(name: Storyboard.organization.rawValue, bundle: Bundle.main)
        let navController = sb.instantiateViewController(withIdentifier: "AddOrganizerNavigation") as? UINavigationController
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    func showIntroScreen(){
        let sb = UIStoryboard(name: Storyboard.session.rawValue, bundle: Bundle.main)
        let  navController = sb.instantiateViewController(withIdentifier: "SessionNavigation") as? UINavigationController
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

