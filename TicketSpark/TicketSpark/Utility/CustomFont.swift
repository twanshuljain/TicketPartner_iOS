//
//  CustomFont.swift
//  TicketSpark
//
//  Created by Apple on 13/02/24.
//

import Foundation
import UIKit

class CustomFont: NSObject {
    static let shared = CustomFont()
    
    private override init() { }
    
    enum FontType {
        case lato
    }
    
    func GETFONTSIZE(fontSize: CGFloat) -> CGFloat {
        
        return fontSize
        
        // MARK: If need the dynamic size font based on device screen size then remove above return and uncomment below code.
        
        //        switch Int(UIScreen.main.bounds.size.height) {
        //        case 480:
        //            return fontSize-7 //iPhone 3.5-inch iPhone 4, iPhone 4S
        //
        //        case 568:
        //            return fontSize-6 //iPhone 4-inch iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
        //
        //        case 667:
        //            return fontSize-3 //iPhone 4.7-inch iPhone 6, iPhone 6S, iPhone 7, iPhone 8
        //
        //        case 736:
        //            return fontSize-2 //iPhone 5.5-inch (Physical) iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
        //
        //        case 812:
        //            return fontSize-3 //iPhone 5.8-inch iPhone X, iPhone XS, iPhone 11 Pro, iPhone 12 mini
        //
        //        case 844:
        //            return fontSize-3 //iPhone 12, iPhone 12 Pro
        //
        //        case 896:
        //            return fontSize-1 //iPhone 6.1-inch iPhone XR, iPhone 11, iPhone Xs Max, iPhone 11 Pro Max
        //
        //        case 926:
        //            return fontSize-1 //iPhone 12 Pro Max
        //
        //        case 1080:
        //            return fontSize-1 //iPad 10.2-inch iPad 10.2
        //
        //        case 1112:
        //            return fontSize-1 //iPad 10.5-inch iPad Pro 10.5, iPad Air 10.5
        //
        //        case 1024:
        //            return fontSize-1 //iPad 9.7-inch Retina iPad 3, iPad 4, iPad Air, iPad Air 2, iPad Pro 9.7-inch, iPad 5th, iPad 6th
        //
        //        case 1194:
        //            return fontSize-1 //11" iPad Pro, 10.5" iPad Pro
        //
        //        case 1366:
        //            return fontSize-1 //iPad Pro 12.9-inch iPad Pro 12.9-inch 1st, 2nd and 3rd Generation
        //
        //        default:
        //            return fontSize
        //        }
    }
    
//    func extraBoldItalic(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
//        return UIFont(name: fontType == .lato ? "openSans-ExtraboldItalic" : "Poppins-ExtraboldItalic", size: GETFONTSIZE(fontSize: sizeOfFont))!
//    }
//
//    func condensedBold(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
//        return UIFont(name: fontType == .lato ? "openSans-ExtraBold" : "Poppins-ExtraBold", size: GETFONTSIZE(fontSize: sizeOfFont))!
//    }
    
    func light(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-Light" : "Lato-Light", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func black(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-Black" : "Lato-Black", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func regular(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-Regular" : "Lato-Regular", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func bold(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-Bold" : "Lato-Bold", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
//    func semiBold(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
//        return UIFont(name: fontType == .lato ? "openSans-Bold" : "Poppins-SemiBold", size: GETFONTSIZE(fontSize: sizeOfFont))!
//    }
    
    func lightItalic(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-LightItalic" : "Lato-LightItalic", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func blackItalic(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-BlackItalic" : "Lato-BlackItalic", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func boldItalic(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-BoldItalic" : "Lato-BoldItalic", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
    func italic(fontType: FontType = .lato, sizeOfFont: CGFloat) -> UIFont {
        return UIFont(name: fontType == .lato ? "Lato-Italic" : "Lato-Italic", size: GETFONTSIZE(fontSize: sizeOfFont))!
    }
    
}
