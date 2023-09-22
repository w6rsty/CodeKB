//
//  HomeScreen.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI


struct NavigationScreen: View {
    @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode: Bool = false
    @State var tab: Tab = .table
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.red
                TabView(selection: $tab) {
                        ForEach(Tab.allCases, id: \.self) { $0 }
                    }
                .tint(Color.white)
            }
        }
        .preferredColorScheme(shouldUseDarkMode ? .dark : .light)
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScreen()
    }
}

