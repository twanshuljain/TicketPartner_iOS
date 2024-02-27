//
//  UIViewController+Extension.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import UIKit

extension UIViewController {
    func showAlert(message: String){
        let alert: UIAlertController = UIAlertController(title: nil,
                                                         message: message,
                                                         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(with text: String, position: SelectPosition, type: AlertType) {
       let bottomAlert = BottomAlert()
       bottomAlert.change_Position(toPosition: position, text: text, type: type)
        if let window: UIWindow = UIApplication.shared.keyWindow {
         window.addSubview(bottomAlert)
         bottomAlert.isHidden = false
         bottomAlert.animationShow(from: position)
       }
     }
     func hideAlert() {
       if let window: UIWindow = UIApplication.shared.keyWindow {
         for view in window.subviews where view is BottomAlert {
           view.animationHide()
         }
       }
     }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func jsonSerial() -> [[String: String]]{
        var countries = [[String: String]]()
        let data = try? Data(contentsOf: URL(fileURLWithPath: (Bundle.main.path(forResource: "countries", ofType: "json"))!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            countries = parsedObject as! [[String : String]]
            return countries
            
        }catch{
            
        }
        return countries
    }
    
//    func getCurrentLanguageIdentifier() -> String? {
//        let preferredLanguage = Bundle.main.preferredLocalizations.first
//        return Locale(identifier: preferredLanguage ?? "").languageCode
//    }
    
    func getCurrentLanguageIdentifier() -> String? {
        let currentLocale = Locale.current

        _ = currentLocale.languageCode
        let regionCode = currentLocale.regionCode

        return regionCode
    }
}
