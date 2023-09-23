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
        
    static func example(_ start: Int32, _ end: Int32) -> Lesson {
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


