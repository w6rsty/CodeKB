//
//  AppStorage+.swift
//  KB
//
//  Created by ZichenFeng on 2023/9/3.
//

import SwiftUI

extension UserDefaults {
    enum Key: String {
        case shouldUseDarkMode
        case userID
        case bgOpacity
    }
}

extension AppStorage {
    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue,key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == String {
        self.init(wrappedValue: wrappedValue,key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == Double {
        self.init(wrappedValue: wrappedValue,key.rawValue, store: store)
    }
}
