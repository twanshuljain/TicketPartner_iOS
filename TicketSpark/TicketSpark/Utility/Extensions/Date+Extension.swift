//
//  Date+Extension.swift
//  TicketSpark
//
//  Created by Apple on 06/03/24.
//

import Foundation

extension Date {
 //Calculate days between two day objects
func daysBetween(_ date: Date) -> Int {
    let calendar = NSCalendar.current

    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: date)
    let date2 = calendar.startOfDay(for: self)

    let components = calendar.dateComponents([.day], from: date1, to: date2)

    return components.day ?? 0  // This will return the number of day(s) between dates
  }
  
    func convertDateToStringFormatMMMDDYYY() -> String{
        let dateToConvert = self // Replace this with your actual Date object

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"

        let formattedDateString = dateFormatter.string(from: dateToConvert)
        return formattedDateString
    }
}
