//
//  ContentView.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var settings = GameSettings.shared
    
    @State private var currentCategories: [Categories] = []
    
    @State var availableCategories: [Categories] = Categories.allCases
    @State private var selectedCategories: [Categories] = []
    @State private var showingAlert = false
    
    @State private var settingUpNewGame = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if settingUpNewGame {
                VStack {
                    TitleView()
                    Spacer()
                    MultiSelectPickerView(sourceItems: availableCategories, selectedItems: $selectedCategories)
                    Spacer()
                    Button(action: {
                        if selectedCategories.count == settings.categoryCount {
                            currentCategories = selectedCategories
                            availableCategories.removeAll(where: { selectedCategories.contains($0) })
                            selectedCategories = []
                            settingUpNewGame = false
                        } else {
                            showingAlert = true
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                                .frame(width: 150, height: 50)
                            Text("Start Game")
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }
                    })
                }
                .padding()
                .alert("Please Select \(settings.categoryCount) Categories", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                }
            } else {
                VStack {
                    TitleView()
                    Spacer()
                    GameBoardView(categories: currentCategories)
                    Spacer()
                    Button(action: {
                        SoundManager.shared.stopSmoothly(duration: 0.5)
                        settingUpNewGame = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                                .frame(width: 150, height: 50)
                            Text("New Game")
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }
                    })
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
