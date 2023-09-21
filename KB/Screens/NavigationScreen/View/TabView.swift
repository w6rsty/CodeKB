//
//  TabVIew.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI




extension NavigationScreen {
    enum Tab: String, View, CaseIterable, RawRepresentable {
        case table,setting
        
        var body: some View {
            ZStack {
                gradient
                    .opacity(0.6)
                    .ignoresSafeArea()
                content
            }
            .tabItem { tabLabel }
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .table: TableScreen()
            case .setting: SettingScreen()
            }
        }
        
        @ViewBuilder
        private var tabLabel: some View {
            switch self {
            case .table: Label("主页", systemImage: .table)
            case .setting: Label("设置", systemImage: .setting)
            }
        }
    }
}

