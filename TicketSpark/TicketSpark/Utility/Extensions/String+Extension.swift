//
//  String+Extension.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
import UIKit
import CoreImage

extension String {
    public func trim() -> String {
       return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func timeStampToString(timeStamp: Double) -> (strdate: String, strtime: String)? {
        let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss a"
       // timeFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeString = timeFormatter.string(from: date as Date)
        return (dateString, timeString)
    }
    
    var toDouble: Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0.0
    }
   
    var toInt: Int {
        return NumberFormatter().number(from: self)?.intValue ?? 0
    }
    
    
//    func getDateFormattedFrom(_ dateFormate: String = "MMM d") -> String {
//        let dateFormatter = DateFormatter()
//        let tempLocale = dateFormatter.locale // save locale temporarily
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        if dateFormatter.date(from: self) == nil{
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            let date = dateFormatter.date(from: self) ?? Date.init()
//            dateFormatter.dateFormat = dateFormate
//            dateFormatter.locale = tempLocale // reset the locale
//            let dateString = dateFormatter.string(from: date)
//            return dateString
//        }else{
//            let date = dateFormatter.date(from: self) ?? Date.init()
//            dateFormatter.dateFormat = dateFormate
//            dateFormatter.locale = tempLocale // reset the locale
//            let dateString = dateFormatter.string(from: date)
//            return dateString
//        }
//        //?? Date.init()
//
//    }
    func getDateFormattedFrom(_ dateFormate: String = "MMM d") -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = .current
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        if dateFormatter.date(from: self) == nil {
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
          let date = dateFormatter.date(from: self) ?? Date.init()
          dateFormatter.dateFormat = dateFormate
          dateFormatter.locale = tempLocale // reset the locale
          let dateString = dateFormatter.string(from: date)
          return dateString
        } else {
          let date = dateFormatter.date(from: self) ?? Date.init()
          dateFormatter.dateFormat = dateFormate
          dateFormatter.locale = tempLocale // reset the locale
          let dateString = dateFormatter.string(from: date)
          return dateString
        }
      }
    
    func getDateFormattedFromTo() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
    }
    
    func removeTimeFromDate() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
    }
    
    func getDayFormattedFromTo() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "EEE"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "EEE"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
    }
    
    func getDateFormattedISOFromTo() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX"
        //dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        if dateFormatter.date(from: self) == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }else{
            let date = dateFormatter.date(from: self) ?? Date.init()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
    }
    
    
    
    func changeDateFormate() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        // dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: self) ?? Date.init()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func convertToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.timeZone = .current
        //formatter.timeZone = TimeZone(abbreviation: "GMT")
        let result = formatter.date(from: self) ?? Date()
        return result
      }
      func convertStringToDateForTime() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let result = formatter.date(from: self) ?? Date()
        return result
      }
    
    func getFormattedTime() -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: self) ?? Date.init()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getDateFormattedDateFromString(_ timeFormat: String = "dd MMM yyyy", _ stringDateFormate: String = "dd MMM yyyy") -> Date {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = stringDateFormate
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = timeFormat
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        let mainDate = dateFormatter.date(from: dateString) ?? Date()
        return mainDate
    }
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        _ = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date) ?? Date()
        return date
    }
    func convertStringToDateForProfile(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let date = dateFormatter.date(from: date) ?? Date()
        return date
    }
    func getCleanedURL() -> URL? {
        guard self.isEmpty == false else {
            return nil
        }
        if let url = URL(string: self) {
            return url
        } else {
            if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
                return escapedURL
            }
        }
        return nil
    }
    
    func getSeparatedFirstName() -> String{
        var firstName = ""
        var components = self.components(separatedBy: " ")
        if components.count > 0 {
         firstName = components.removeFirst()
            _ = components.joined(separator: " ")
         debugPrint(firstName)
        }
        
        return firstName
    }
    
    func getSeparatedLastName() -> String{
        var lastName = ""
        var components = self.components(separatedBy: " ")
        if components.count > 0 {
            _ = components.removeFirst()
         lastName = components.joined(separator: " ")
         debugPrint(lastName)
        }
        return lastName
    }
    

    func generateQRCode(qrCodeImageView:UIImageView) -> UIImage? {
        if let data = Data(base64Encoded: self) {
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter?.setValue(data, forKey: "inputMessage")

            if let qrImage = qrFilter?.outputImage {
                let scaleX = qrCodeImageView.frame.size.width / qrImage.extent.size.width
                let scaleY = qrCodeImageView.frame.size.height / qrImage.extent.size.height
                let transformedImage = qrImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

                return UIImage(ciImage: transformedImage)
            }
        }

        return nil
    }
    
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    func getCountry() -> String{
        return Locale.current.localizedString(forRegionCode: Locale.current.regionCode ?? "") ?? "Toronto"
    }
    // Passwords Validations
    func isValidPasswords(password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-={};:',.<>?/\\|]).{8,}$"
        let passPred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func addAttributedString(highlightedString: String, highlightedColor: UIColor? = .red) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: highlightedString)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightedColor ?? .red, range: range)
            return attributedString
    }
    
    func convertStringToDateFormatMMDDYYY() -> Date? {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: Locale.current.identifier) // Set the locale to ensure consistent date formatting
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
           return nil
        }
    }
    
    func getMinimumTime(startDate: String) -> Date? {
        let calendar = Calendar.current
        // Get today's date
        let currentDate = startDate.convertStringToDateFormatMMDDYYY() ?? Date()
        
        // Get the components of today's date
        var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        // Set the hour and minute
        components.hour = (self.getHourFromTime() as NSString).integerValue
        components.minute = 0
        
        // Get the date for today at 4 PM
        if let minimumDate = calendar.date(from: components) {
            // Set the minimum date for the time picker
            return minimumDate
        }
        
        return nil
    }
    
    func changeDateFormatFromMMddyyyTOyyyMMdd() -> String {
        // Create a date formatter to parse the input date string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "MMM dd, yyyy"

        // Parse the input date string
        if let inputDate = inputDateFormatter.date(from: self) {
            // Create a date formatter to format the output date string
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"
            
            // Format the parsed date to the desired output format
            let outputDateString = outputDateFormatter.string(from: inputDate)
            
            // Print the result
            return outputDateString
        } else {
            print("Failed to parse input date")
        }
        return ""
    }
    
    func changeTimeFormatFromMMddyyyTOyyyMMdd() -> String {
        // Input time string
        let inputTime = self

        // Create a date formatter to parse the input time string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "h:mm a"

        // Parse the input time string
        if let date = inputDateFormatter.date(from: inputTime) {
            // Create a date formatter to format the output time string
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm"
            
            // Format the parsed date to the desired output format
            let outputTime = outputDateFormatter.string(from: date)
            
            // Print the result
            print(outputTime) // Output: 12:30
            return outputTime
        } else {
            print("Failed to parse input time")
        }
        
        return ""
    }
    
    func getHourFromTime() -> String {
        // Input time string
        let inputTime = self

        // Create a date formatter to parse the input time string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "h:mm a"

        // Parse the input time string
        if let date = inputDateFormatter.date(from: inputTime) {
            // Create a date formatter to format the output time string
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH"
            
            // Format the parsed date to the desired output format
            let outputTime = outputDateFormatter.string(from: date)
            
            // Print the result
            print(outputTime) // Output: 12:30
            return outputTime
        } else {
            print("Failed to parse input time")
        }
        
        return ""
    }
//    func convertStringToTimeHMMA() -> Date? {
//        let dateString = self
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mm a"
//        if let date = dateFormatter.date(from: dateString) {
//            return date
//        } else {
//           return nil
//        }
//    }
    
    func convertStringToTimeHMMA() -> Date? {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            let formattedDateFormatter = DateFormatter()
            formattedDateFormatter.dateFormat = "h:mm a"
            
            let formattedTimeString = formattedDateFormatter.string(from: date)
            if let formattedDate = formattedDateFormatter.date(from: formattedTimeString) {
                return formattedDate
            }
        }
        
        return nil
    }
    
    func changeDateFormattt(time: String) -> Date? {
        let finalTime = time.changeTimeFormatFromMMddyyyTOyyyMMdd()
        let date = self.changeDateFormatFromMMddyyyTOyyyMMdd()
        
        let finalDate = "\(date)T\(finalTime):00"
        
        // Create a date formatter with the desired format
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        // Get the current date and time
        let currentDate = finalDate

        // Convert the date to a string in the specified format
        let formattedDate = dateFormatter.date(from: finalDate)

        print(formattedDate)
        
        return formattedDate
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
