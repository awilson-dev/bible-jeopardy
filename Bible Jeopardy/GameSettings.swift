//
//  Settings.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/24/23.
//

import SwiftUI

class GameSettings: ObservableObject {
    @AppStorage("category_count") var categoryCount = 5
    @AppStorage("hidden_treasure_enabled") var hiddenTreasureEnabled = false
    
    static let shared = GameSettings()
}
