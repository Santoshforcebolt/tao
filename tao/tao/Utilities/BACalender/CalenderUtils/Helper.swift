//
//  Helper.swift
//  BACalender
//
//  Created by Betto Akkara on 20/10/20.
//  Copyright © 2020 Betto Akkara. All rights reserved.
//

import UIKit

public struct Helper {
    
    /// Generates a random string with the given length
    public static func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }

    public static func calendarAdvanced(byAdding : Calendar.Component,  value: Int,  startDate: Date) -> Date {
        return Calendar.current.date(byAdding: byAdding, value: value, to: startDate) ?? startDate
    }
    
    public func yearsBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: start, to: end).year!
    }
    
    public func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    public func hoursBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: start, to: end).hour!
    }
    public func minutesBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: start, to: end).minute!
    }
    public func secondsBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: start, to: end).second!
    }
    
    public func addDays(days: Int) -> String {
        let today = Date()
        let futureDate = Calendar.current.date(byAdding: .day, value: days, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: futureDate)
    }
}
public func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }



}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

