//
//  ContentView.swift
//  Bible Jeopardy (iPad)
//
//  Created by Allen Wilson on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = GameManager.shared
    @StateObject var settings = GameSettings.shared
    
    @State var reset = false
    @State var newGame = false
    @State var showSettings = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if manager.settingUpNewGame {
                ZStack {
                    MultiSelectPickerView(sourceItems: $manager.availableCategories, selectedItems: $manager.selectedCategories)
                    
                    VStack {
                        Color.black
                            .frame(height: 50)
                        
                        Spacer()
                        
                        Color.black
                            .frame(height: 30)
                    }
                    .allowsHitTesting(false)
                    
                    VStack {
                        Color.black
                            .blur(radius: 20)
                            .frame(height: 120)
                        
                        Spacer()
                        
                        Color.black
                            .blur(radius: 20)
                            .frame(height: 80)
                    }
                    .allowsHitTesting(false)
                    
                    VStack {
                        TitleView()
                            .allowsHitTesting(false)
                        
                        Spacer()
                        
                        ZStack {
                            Button(action: {
                                if manager.selectedCategories.count == settings.categoryCount {
                                    manager.currentCategories = manager.selectedCategories
                                    manager.availableCategories.removeAll(where: { manager.selectedCategories.contains($0) })
                                    manager.selectedCategories = []
                                    manager.settingUpNewGame = false
                                } else {
                                    manager.showingAlert = true
                                }
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.accentColor)
                                        .frame(width: 150, height: 50)
                                    
                                    Text("Start Game")
                                        .font(.custom("Arial Rounded MT Bold", size: 20))
                                        .bold()
                                        .foregroundColor(.white)
                                }
                            })
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    showSettings = true
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.gray)
                                            .frame(width: 120, height: 50)
                                        
                                        Text("Settings")
                                            .font(.custom("Arial Rounded MT Bold", size: 20))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                })
                                
                                Button(action: {
                                    reset = true
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.red)
                                            .frame(width: 100, height: 50)
                                        
                                        Text("Reset")
                                            .font(.custom("Arial Rounded MT Bold", size: 20))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                })
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
                .padding()
                .alert(isPresented: $manager.showingAlert) {
                    Alert(title: Text("Please Select \(settings.categoryCount) Categories\n(\(manager.selectedCategories.count) currently selected)"), message: nil, dismissButton: .cancel(Text("OK")))
                }
                .alert("This will reset the entire game. Do you want to continue?", isPresented: $reset) {
                    Button("Reset") {
                        var newCategories: [Categories] = []
                        var oldCategories: [Categories] = []
                        
                        for item in Categories.allCases {
                            if Categories.newCategories.contains(item) {
                                newCategories.append(item)
                            } else {
                                oldCategories.append(item)
                            }
                        }
                        
                        manager.availableCategories = newCategories + oldCategories
                        manager.selectedCategories = []
                        
                        reset = false
                    }
                    .keyboardShortcut(.defaultAction)
                    
                    Button("Cancel") {
                        reset = false
                    }
                    .keyboardShortcut(.cancelAction)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                        .presentationBackground(.clear)
                        .presentationDetents([.medium])
                }
            } else {
                VStack {
                    TitleView()
                    
                    Spacer()
                    
                    GameBoardView(categories: manager.currentCategories)
                    
                    Spacer()
                    
                    Button(action: {
                        newGame = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 150, height: 50)
                            
                            Text("New Game")
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }
                    })
                    .buttonStyle(.plain)
                }
                .padding()
                .alert("This will reset the game board for a new round. Do you want to continue?", isPresented: $newGame) {
                    Button("New Game") {
                        SoundManager.shared.stopSmoothly(duration: 0.5)
                        manager.settingUpNewGame = true
                        manager.reset()
                    }
                    .keyboardShortcut(.defaultAction)
                    
                    Button("Cancel") {
                        newGame = false
                    }
                    .keyboardShortcut(.cancelAction)
                }
            }
        }
        .frame(minWidth: 700, minHeight: 620)
    }
}

#Preview {
    ContentView()
}
