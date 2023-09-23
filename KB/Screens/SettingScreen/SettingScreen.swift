//
//  SettingScreen.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI

struct SettingScreen: View {
    @AppStorage(.userID) private var userID: String = ""
    @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode: Bool = false
    @AppStorage(.bgOpacity) private var bgOpacity: Double = 1
    @AppStorage(.beginYear) private var beginYear: Int = 0
    @AppStorage(.beginMonth) private var beginMonth: Int = 0
    @AppStorage(.beginDay) private var beginDay: Int = 0
    @State private var beginDate = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("学号", text: $userID)
                
                DatePicker(
                    "开学日期",
                    selection: $beginDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .onAppear {
                    beginDate = Date.init(year: beginYear, month: beginMonth, day: beginDay)
                }
                .onChange(of: beginDate) { date in
                    beginYear = date.yearInt
                    beginMonth = date.monthInt
                    beginDay = date.dayInt
                    print("set date to \(beginYear) \(beginMonth) \(beginDay)")
                }
            }
            Section {
                Toggle(isOn: $shouldUseDarkMode) {
                    Label("深色模式", systemImage: .moon)
                }
            }
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
