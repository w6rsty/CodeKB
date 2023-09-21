//
//  TableView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI

struct TableView: View {
    @Binding var schedule: Schedule?
    let week = Week.example()
    
    var body: some View {
        ScheduleView(numberOfWeeks: 20, weeks: [week, week])
            .background(Color.clear)
    }
}

extension TableView {
    var testButton: some View {
        Button("Test") {
            if let data = schedule {
                for lesson in data.monday {
                    print(lesson.lessonName)
                }
            } else {
                print("test button: fail to read courses")
            }
        }
    }
}


struct TableView_Preview: PreviewProvider {
    static var previews: some View {
        TableView(
            schedule: .constant(
                Schedule.example()
            )
        )
    }
}
