//
//  WeekView.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/21.
//

import SwiftUI

struct WeekView: View {
    let week: Week
    var body: some View {
        Text(week.monday[0].lessonName)
    }
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView()
//    }
//}
