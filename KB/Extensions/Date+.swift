//
//  Date+.swift
//  Time Master
//
//  Created by ZichenFeng on 2023/8/14.
//

import Foundation
import SwiftUI


extension Date {
    
    init(year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        self.init(timeInterval: 0, since: calendar.date(from: dateComponents)!)
    }
    
    func plainCopy() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self.yearInt
        dateComponents.month = self.monthInt
        dateComponents.day = self.dayInt
        
        return Date(timeInterval: 0, since: calendar.date(from: dateComponents)!)
    }
    
    func toNextWeek() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self.yearInt
        dateComponents.month = self.monthInt
        dateComponents.day = self.dayInt + 7
        
        return Date(timeInterval: 0, since: calendar.date(from: dateComponents)!)
    }
    
    func toPrevWeek() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self.yearInt
        dateComponents.month = self.monthInt
        dateComponents.day = self.dayInt - 7
        
        return Date(timeInterval: 0, since: calendar.date(from: dateComponents)!)
    }
    
    var dayInt: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }

    var monthInt: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    var yearInt: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    var weekdayInt: Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }

    var monthString: String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return calendar.monthSymbols[month-1]
    }
    
    var monthShortString: String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return calendar.shortMonthSymbols[month-1]
    }
    
    var weekdayString: String {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: self)
        return calendar.weekdaySymbols[weekDay-1]
    }
    
    var shortWeekdayString: String {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: self)
        return calendar.shortWeekdaySymbols[weekDay-1]
    }
    
    var monthAndDayString: String {
        return "\(self.monthInt)月\(self.dayInt)日"
    }
    
    var yearMonthAndDayString: String {
        return "\(self.yearInt)年\(self.monthInt)月\(self.dayInt)日"
    }
    
    var toWeek: WeekDate {
        return WeekDate(self)
    }
    
    static func dayEqual(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        
        return components1 == components2
    }
}

extension Binding where Value == Date {
    static func == (lhs: Binding<Date>, rhs: Binding<Date>) -> Bool {
        Date.dayEqual(lhs.wrappedValue, rhs.wrappedValue)
    }
}
