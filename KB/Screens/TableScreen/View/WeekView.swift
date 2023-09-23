//
//  WeekView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/21.
//

import SwiftUI

struct WeekView: View {
    let week: Week
    
    private struct BuildInfo {
        let blockWidth: CGFloat
        let blockHeight: CGFloat
    }
    
    var body: some View {
        GeometryReader { proxy in
            let info = BuildInfo(
                blockWidth: proxy.size.width / 7,
                blockHeight: proxy.size.height / 10
            )
            HStack(spacing: 0) {
                buildOneday(info: info, day: week.monday)
                buildOneday(info: info, day: week.tuesday)
                buildOneday(info: info, day: week.wednesday)
                buildOneday(info: info, day: week.thursday)
                buildOneday(info: info, day: week.friday)
                buildOneday(info: info, day: week.saturday)
                buildOneday(info: info, day: week.sunday)
            }
        }
    }
    
    private func buildOneday(info: BuildInfo, day: [Lesson]) -> some View {
        ZStack {
            ForEach(Array(day.enumerated()), id: \.offset) { index, lesson in
                VStack(spacing: 0) {
                    Text(lesson.lessonName)
                }
                .frame(width: info.blockWidth, height: CGFloat(lesson.blockLength) * info.blockHeight)
                .background(RoundedRectangle(cornerRadius: 8).fill(gradient))
                .offset(y: CGFloat(lesson.startBlock - 1) * info.blockHeight)
            }
        }
        .frame(width: info.blockWidth)
    }
}


