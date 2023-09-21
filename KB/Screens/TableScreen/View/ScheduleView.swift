//
//  ScheduleView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/21.
//

import SwiftUI


struct Item: Identifiable {
    var id = UUID()
    let color: Color
}

struct ScheduleView: View {
    // 总周数
    let numberOfWeeks: Int
    let weeks: [Week]
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    // 翻页需要滑动的距离
    private let dragThreshold: CGFloat = 100
    // 定义如何构建Week的样式
    
    var body: some View {
        GeometryReader { proxy in
            let itemHeight: CGFloat = proxy.size.height
            let itemWidth: CGFloat = proxy.size.width
            VStack(spacing: 0) {
                ForEach(weeks.indices, id: \.self) { index in
                    WeekView(week: weeks[index])
                        .frame(width: itemWidth, height: itemHeight)
                        .scaleEffect(setScaleValue(at: index, height: itemHeight, in: proxy))
                        .opacity(setOpacity(at: index, height: itemHeight, in: proxy))
                }
            }
            .offset(y: calculateOffest(currentIndex, itemHeight) + dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        withAnimation(.easeInOut) {
                            dragOffset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            finalizePosition(dragValue: value)
                            dragOffset = 0
                        }
                    }
            )
            .clipShape(Rectangle())
        }
    }
}


extension ScheduleView {
    func calculateOffest(_ index: Int, _ itemHeight: CGFloat) -> CGFloat {
        return -CGFloat(index) * itemHeight
    }
    
    func setScaleValue(at index: Int, height itemHeight: CGFloat,in geometry: GeometryProxy) -> CGFloat {
        let currentItemOffset = calculateOffest(index, itemHeight) + dragOffset
        let itemPostion = CGFloat(index) * itemHeight + currentItemOffset
        let distanceFromCenter = abs(geometry.size.height / 2 - itemPostion - itemHeight / 2)
        let scale: CGFloat = 0.8 + (0.2 * (1 - min(1, distanceFromCenter / itemHeight)))
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
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView()
//    }
//}
