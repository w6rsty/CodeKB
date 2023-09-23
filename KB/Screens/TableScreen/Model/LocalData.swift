//
//  LocalData.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/21.
//

import Foundation

// App内部使用的数据模型

// 一周的课程
struct Week {
    var monday: [Lesson]
    var tuesday: [Lesson]
    var wednesday: [Lesson]
    var thursday: [Lesson]
    var friday: [Lesson]
    var saturday: [Lesson]
    var sunday: [Lesson]
}

extension Week {
    static func example() -> Week {
        return Week (
            monday: [Lesson.example(1,2)],
            tuesday: [Lesson.example(3,4)],
            wednesday: [Lesson.example(5,6)],
            thursday: [Lesson.example(7,8)],
            friday: [Lesson.example(9,10)],
            saturday: [Lesson.example(1,2)],
            sunday: [Lesson.example(3,4)]
        )
    }
}

class WeekDate {
    private var calendar = Calendar.current
    var startDate: Date

    init(_ date: Date) {
        calendar.firstWeekday = 2
        startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    }
    
    var monday: Date {
      return startDate
    }
    var tuesday: Date {
      return calendar.date(byAdding: .day, value: 1, to: monday)!
    }
    var wednesday: Date {
      return calendar.date(byAdding: .day, value: 2, to: monday)!
    }
    var thursday: Date {
      return calendar.date(byAdding: .day, value: 3, to: monday)!
    }
    var friday: Date {
      return calendar.date(byAdding: .day, value: 4, to: monday)!
    }
    var saturday: Date {
      return calendar.date(byAdding: .day, value: 5, to: monday)!
    }
    var sunday: Date {
      return calendar.date(byAdding: .day, value: 6, to: monday)!
    }
}


extension Date {
    enum Days: CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
        
        var dateProvider: (WeekDate) -> Date {
            switch self {
            case .monday:
                return { $0.monday }
            case .tuesday:
                return { $0.tuesday }
            case .wednesday:
                return { $0.wednesday }
            case .thursday:
                return { $0.thursday }
            case .friday:
                return { $0.friday }
            case .saturday:
                return { $0.saturday }
            case .sunday:
                return { $0.sunday }
            }
        }
        
        var dateChar: String {
            switch self {
            case .monday:
                return "一"
            case .tuesday:
                return "二"
            case .wednesday:
                return "三"
            case .thursday:
                return "四"
            case .friday:
                return "五"
            case .saturday:
                return "六"
            case .sunday:
                return "日"
            }
        }
    }
}

