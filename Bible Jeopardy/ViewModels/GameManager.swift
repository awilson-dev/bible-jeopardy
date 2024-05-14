//
//  GameManagerView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/26/23.
//

import SwiftUI

class GameManager: ObservableObject {
    // ContentView
    @Published var currentCategories: [Categories] = []
    
    @Published var availableCategories: [Categories] = Categories.allCases
    @Published var selectedCategories: [Categories] = []
    @Published var showingAlert = false
    
    @Published var settingUpNewGame = true
    
    // GameBoardView
    @Published var currentQuestion: Question? = nil
    @Published var showingAnswer: Bool = false
    @Published var completed = Array(repeating: Array(repeating: false, count: 5), count: 6)
    
    @Published var hiddenTreasureX = Int.random(in: 0 ..< 6)
    @Published var hiddenTreasureY = Int.random(in: 0 ..< 5)
    
    @Published var hiddenTreasure = Array(repeating: Array(repeating: false, count: 5), count: 6)
    @Published var currentIsHiddenTreasure = false
    @Published var hiddenTreasureColor: Color = Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
    
    static let shared = GameManager()
    
    func reset() {
        let settings = GameSettings.shared
        
        // ContentView
        currentCategories = []
        selectedCategories = []
        showingAlert = false
        
        settingUpNewGame = true
        
        // GameBoardView
        currentQuestion = nil
        showingAnswer = false
        completed = Array(repeating: Array(repeating: false, count: 5), count: settings.categoryCount)
        
        hiddenTreasureX = Int.random(in: 0 ..< settings.categoryCount)
        hiddenTreasureY = Int.random(in: 0 ..< 5)
        
        hiddenTreasure = Array(repeating: Array(repeating: false, count: 5), count: settings.categoryCount)
        currentIsHiddenTreasure = false
        hiddenTreasureColor = Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
    }
}
