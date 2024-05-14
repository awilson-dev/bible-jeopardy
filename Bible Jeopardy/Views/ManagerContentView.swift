//
//  ManagerContentView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/26/23.
//

import SwiftUI

struct ManagerContentView: View {
    @StateObject var manager = GameManager.shared
    @StateObject var settings = GameSettings.shared
    
    @State var reset = false
    
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
                                        .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
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
            } else {
                VStack {
                    TitleView()
                    
                    Spacer()
                    
                    ManagerGameBoardView(categories: manager.currentCategories)
                    
                    Spacer()
                    
                    Button(action: {
                        SoundManager.shared.stopSmoothly(duration: 0.5)
                        manager.settingUpNewGame = true
                        manager.reset()
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
                    .buttonStyle(.plain)
                }
                .padding()
            }
        }
        .frame(minWidth: 700, minHeight: 620)
    }
}

#Preview {
    ManagerContentView()
        .frame(width: 1000, height: 700)
}
