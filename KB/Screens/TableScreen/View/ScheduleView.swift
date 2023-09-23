//
//  ScheduleView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/21.
//

import SwiftUI

struct ScheduleView: View {
    // 总周数
    let numberOfWeeks: Int
    let weeks: [Week]

    // 翻页需要滑动的距离
    private let dragThreshold: CGFloat = 50
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width / 8
            VStack(spacing: 0) {
                buildWeekHead(width)
                    .border(.red)
                HStack(spacing: 0) {
                    buildWeekLeft(width)
                        .border(.red)
                    buildWeekView(proxy: proxy)
                }
            }
            .background(Color.clear)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        withAnimation(.easeInOut) {
                            dragOffset = value.translation.height * 0.8
                        }
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            finalizePosition(dragValue: value)
                            dragOffset = 0
                        }
                    }
            )
        }
    }
}


extension ScheduleView {
    @ViewBuilder
    func buildWeekView(proxy: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            GeometryReader { weekProxy in
                VStack(spacing: 0) {
                    GeometryReader { inner in
                        VStack(spacing: 0) {
                            ForEach(weeks.indices, id: \.self) { index in
                                WeekView(week: weeks[index])
                                    .frame(width: inner.size.width, height: inner.size.height)
                                    .scaleEffect(setScaleValue(at: index, height: weekProxy.size.height, in: proxy))
                                    .opacity(setOpacity(at: index, height: weekProxy.size.height, in: proxy))
                                    .border(.red)
                            }
                        }
                    }
                }
                .offset(y: calculateOffest(currentIndex, weekProxy.size.height) + dragOffset)
                .clipShape(Rectangle())
            }
        }
    }
    
    
    func calculateOffest(_ index: Int, _ itemHeight: CGFloat) -> CGFloat {
        return -CGFloat(index) * itemHeight
    }
    
    func setScaleValue(at index: Int, height itemHeight: CGFloat,in geometry: GeometryProxy) -> CGFloat {
        let currentItemOffset = calculateOffest(index, itemHeight) + dragOffset
        let itemPostion = CGFloat(index) * itemHeight + currentItemOffset
        let distanceFromCenter = abs(geometry.size.height / 2 - itemPostion - itemHeight / 2)
        let scale: CGFloat = 0.9 + (0.1 * (1 - min(1, distanceFromCenter / itemHeight)))
        return scale

    }
    
    func setOpacity(at index: Int, height itemHeight: CGFloat,in geometry: GeometryProxy) -> Double {
        if abs(index - currentIndex) > 1 {
            return 0
        }
        let currentItemOffset = calculateOffest(index, itemHeight) + dragOffset
        let itemPostion = CGFloat(index) * itemHeight + currentItemOffset
        let distanceFromCenter = abs(geometry.size.height / 2 - itemPostion - itemHeight / 2)
        
        var opacity: Double = 1
        if abs(index - currentIndex) == 1 {
            opacity = distanceFromCenter / (0.7 * itemHeight)
        }
        return opacity
    }
    
    func finalizePosition(dragValue: DragGesture.Value) {
        if dragValue.predictedEndTranslation.height > dragThreshold && currentIndex > 0 {
            currentIndex -= 1
        }
        else if dragValue.predictedEndTranslation.height < -dragThreshold && currentIndex < numberOfWeeks - 1 {
            currentIndex += 1
        }
    }
    
    @ViewBuilder
    func buildWeekHead(_ width: CGFloat) -> some View {
        HStack(spacing: 0) {
            Spacer(minLength: width)
            Text("一").frame(maxWidth: width)
            Text("二").frame(maxWidth: width)
            Text("三").frame(maxWidth: width)
            Text("四").frame(maxWidth: width)
            Text("五").frame(maxWidth: width)
            Text("六").frame(maxWidth: width)
            Text("日").frame(maxWidth: width)
        }
    }
    
    @ViewBuilder
    func buildWeekLeftCell(num: String, begin: String, end: String) -> some View {
        VStack(spacing: 0) {
            Text(num).font(.headline)
            Text(begin).font(.caption)
            Text(end).font(.caption)
        }.frame(maxHeight: .infinity).border(.blue)
    }
    
    @ViewBuilder
    func buildWeekLeft(_ width: CGFloat) -> some View {
        VStack(spacing: 0) {
            buildWeekLeftCell(num: "1", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "2", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "3", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "4", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "5", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "6", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "7", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "8", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "9", begin: "08:00", end: "8:50")
            buildWeekLeftCell(num: "10", begin: "08:00", end: "8:50")
        }
        .frame(width: width)
    }
}
