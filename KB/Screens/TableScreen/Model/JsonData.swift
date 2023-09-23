//
//  day.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/9.
//

import SwiftUI

// json解析的数据模型
struct Lesson: Codable {
    var lessonName: String
    var blockLength: Int32
    var startBlock: Int
    var endBlock: Int
    var campus: String
    var classroom: String
    var teacher: String
    var credit: Float
    var weeks: [Int]
        
    static func example(_ start: Int, _ end: Int) -> Lesson {
        return Lesson(lessonName: "电竞集训", blockLength: 2, startBlock: start, endBlock: end, campus: "Internet Cafe", classroom: "A101", teacher: "Billy", credit: 3.5, weeks: [1, 2, 3])
    }
}

// 总表
struct Schedule: Codable {
    var monday: [Lesson]
    var tuesday: [Lesson]
    var wednesday: [Lesson]
    var thursday: [Lesson]
    var friday: [Lesson]
    var saturday: [Lesson]
    var sunday: [Lesson]
    
    func toWeeks() -> [Week] {
        var weeks = Array(repeating: Week.empty(), count: 20)
        
        for lesson in monday {
            for num in lesson.weeks {
                weeks[num - 1].monday.append(lesson)
            }
        }
        for lesson in tuesday {
            for num in lesson.weeks {
                weeks[num - 1].tuesday.append(lesson)
            }
        }
        for lesson in wednesday {
            for num in lesson.weeks {
                weeks[num - 1].wednesday.append(lesson)
            }
        }
        for lesson in thursday {
            for num in lesson.weeks {
                weeks[num - 1].thursday.append(lesson)
            }
        }
        for lesson in friday {
            for num in lesson.weeks {
                weeks[num - 1].friday.append(lesson)
            }
        }
        for lesson in saturday {
            for num in lesson.weeks {
                weeks[num - 1].saturday.append(lesson)
            }
        }
        for lesson in sunday {
            for num in lesson.weeks {
                weeks[num - 1].sunday.append(lesson)
            }
        }
        return weeks
    }
}


