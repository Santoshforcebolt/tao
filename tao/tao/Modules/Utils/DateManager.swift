//
//  DateManager.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation

class DateManager {
    
    static let shared = DateManager()
    
    private init() {
        //
    }
    
    func getCurrentMonth() -> Int {
        return Calendar.current.component(.month, from: Date())
    }
    
    func getCurrentYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    func getDateBetween(from start: String, to end: String) -> [String] {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"

        guard let startDate = format.date(from: start),
            let endDate = format.date(from: end) else {
                return []
        }

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(Set([.month]), from: startDate, to: endDate)

        var allDates: [String] = []
        let dateRangeFormatter = DateFormatter()
        dateRangeFormatter.dateFormat = "MMM yyyy"

        for i in 0 ... components.month! {
            guard let date = calendar.date(byAdding: .month, value: i, to: startDate) else {
            continue
            }

            let formattedDate = dateRangeFormatter.string(from: date)
            allDates += [formattedDate]
        }
        return allDates.reversed()
    }
    
    func getTodayDateString(outputFormat : String? = "dd/MM/yyyy") -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: Date())
    }
    
    func getMonthAndYearInt(from date: String, inputFormat: String = "MMM yyyy") -> (Int, Int) {
        let format = DateFormatter()
        format.dateFormat = inputFormat
        if let date = format.date(from: date) {
            return (Calendar.current.component(.month, from: date), Calendar.current.component(.year, from: date))
        }
        return (0,0)
    }
    
    func getDaysBetween(date1: Date, date2: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date1, to: date2).day ?? 0
    }
}
