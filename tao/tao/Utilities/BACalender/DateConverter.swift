//
//  DateConverter.swift
//  creditcardapp
//
//  Created by FedServ on 09/09/21.
//

import Foundation

/// This is for converting dates to the expected formated strings
class DateConverter{
    //"20-08-2019 02:14:15" dd-MM-yyyy HH:mm:ss
   /// This is for converting dates to the expected formated strings
   ///
   /// - Parameters:
   ///   - date: Input date string
   ///   - inputFormat: Input date format
   ///   - outputFormat: Expected date Format
   /// - Returns: Expected Formated Date in String
   class func convertDateFormat(_ date : String, inputFormat : String? = "yyyy-MM-dd HH:mm:ss",outputFormat : String? = "dd/MM/yyyy") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        let showDate = inputFormatter.date(from: date)
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        if let showdate = showDate{
            let resultString = outputFormatter.string(from: showdate)
            return resultString
        }else{
            return date
        }
    }
    /// This is for converting dates to the expected formated strings
    ///
    /// - Parameters:
    ///   - date: Input Date in Date Format
    ///   - outputFormat: Expected date Format
    /// - Returns: Expected Formated Date in String
    class func convertDateFormat(_ date : Date?, outputFormat : String? = "dd/MM/yyyy") -> String? {

        let showDate = date
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        if let showdate = showDate{
            let resultString = outputFormatter.string(from: showdate)
            return resultString
        }else{
            return ""
        }
    }
    /// This is for converting date string to the 'Date' formated
    ///
    /// - Parameters:
    ///   - date: Input Date in String Format
    ///   - inputFormat: Date Format
    /// - Returns: Date in Date Format
    class func convertDateFormat(_ date : String, inputFormat : String? = "yyyy-MM-dd HH:mm:ss") -> Date {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        if let showdate = inputFormatter.date(from: date) {
            return showdate
        } else {
            return Date()
        }
    }

    
    
    class func getDaysFromNow(from date : Date) -> String
    {
        let calendar = Calendar.current
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        return "\(day)"
    }
    
    
    
}
