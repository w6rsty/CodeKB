//
//  SFSymbols.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI

enum SFSymbols: String {
    case table      = "calendar"
    case setting    = "gearshape"
    case moon       = "moon.fill"
    case question   = "questionmark.circle"
}

extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbols) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}


// @State private var isOff = false
@ViewBuilder
func buildScaleView(state: Binding<Bool>, @ViewBuilder content: @escaping () -> some View) -> some View {
    content()
        .scaleEffect(state.wrappedValue ? 0.2 : 1)
        .offset(x: state.wrappedValue ? UIScreen.main.bounds.width / 2 : 0, y: state.wrappedValue ? UIScreen.main.bounds.height / 2 : 0)
        .opacity(state.wrappedValue ? 0 : 1.0)
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 2), value: state.wrappedValue)
}
