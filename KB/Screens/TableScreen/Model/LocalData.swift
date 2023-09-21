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
    
    static func example() -> Week {
        Week (
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
