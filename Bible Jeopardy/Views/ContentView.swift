//
//  ContentView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = GameManager.shared
    @StateObject var settings = GameSettings.shared
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if manager.settingUpNewGame {
                VStack {
                    TitleView()
                    
                    SelectedCategoriesListView(sourceItems: $manager.availableCategories, selectedItems: $manager.selectedCategories)
                }
                .buttonStyle(.plain)
                .padding()
            } else {
                VStack {
                    TitleView()
                    
                    Spacer()
                    
                    GameBoardView(categories: manager.currentCategories)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .frame(minWidth: 700, minHeight: 620)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1000, height: 700)
    }
}
