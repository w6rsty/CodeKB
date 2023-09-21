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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("学号")
                .font(.title2).bold()
            TextField("必填", text: $userID)
            Text("深色模式")
                .font(.title2).bold()
            Toggle(isOn: $shouldUseDarkMode) {
                Label("", systemImage: .moon)
            }
            Spacer()
        }
        .listStyle(.plain)
        .padding()
        .background(Color.clear)
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
