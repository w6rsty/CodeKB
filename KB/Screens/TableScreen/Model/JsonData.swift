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
    var startBlock: Int32
    var endBlock: Int32
    var campus: String
    var classroom: String
    var teacher: String
    var credit: Float32
    var weeks: [Int32]
    
    static func example() -> Lesson {
        return Lesson(lessonName: "ESport", blockLength: 2, startBlock: 2, endBlock: 2, campus: "Internet Cafe", classroom: "A101", teacher: "Billy", credit: 3.5, weeks: [1, 2, 3])
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
    
    static func example() -> Schedule {
        Schedule(
            monday: [Lesson.example()],
            tuesday: [Lesson.example()],
            wednesday: [Lesson.example()],
            thursday: [Lesson.example()],
            friday: [Lesson.example()],
            saturday: [Lesson.example()],
            sunday: [Lesson.example()]
        )
    }
}


