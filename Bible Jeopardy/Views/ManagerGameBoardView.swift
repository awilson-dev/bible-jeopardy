//
//  ManagerGameBoardView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/26/23.
//

import SwiftUI

struct ManagerGameBoardView: View {
    @StateObject var manager = GameManager.shared
    @StateObject var settings = GameSettings.shared
    
    var categories: [Categories]
    
    init(categories: [Categories]) {
        self.categories = categories
    }
    
    @State var tapDisabled = false
    
    var body: some View {
        if manager.currentQuestion == nil {
            HStack {
                ForEach(categories) { category in
                    VStack {
                        VStack {
                            Text(category.rawValue.displayName)
                                .font(.custom("Arial Rounded MT Bold", size: 18))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(minHeight: 60, idealHeight: 60, maxHeight: 100)
                        
                        ForEach(category.rawValue.questions) { question in
                            let x = categories.firstIndex(of: category)!
                            let y = category.rawValue.questions.firstIndex(of: question)!
                            
                            Button(action: {
                                if !tapDisabled {
                                    manager.currentQuestion = question
                                    
                                    if manager.hiddenTreasure[x][y] {
                                        manager.currentIsHiddenTreasure = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            SoundManager.shared.play("achievementChime", in: 1)
                                        }
                                    }
                                    
                                    if question.hymn != nil {
                                        SoundManager.shared.play(question.hymn!.rawValue)
                                    }
                                    
                                    manager.completed[x][y] = true
                                    
                                    disableTap()
                                }
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                                    
                                    if !manager.completed[x][y] {
                                        Text(question.points == 1 ? "\(question.points)  talent" : "\(question.points)  talents")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                }
                            })
                            .disabled(manager.completed[x][y])
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .aspectRatio(3 / 2, contentMode: .fit)
            .padding()
            .onAppear {
                if settings.hiddenTreasureEnabled {
                    manager.hiddenTreasure[manager.hiddenTreasureX][manager.hiddenTreasureY] = true
                }
            }
        } else {
            Button(action: {
                if !tapDisabled {
                    if !manager.showingAnswer {
                        manager.showingAnswer = true
                    } else {
                        SoundManager.shared.stopSmoothly(duration: 0.5)
                        manager.currentQuestion = nil
                        manager.currentIsHiddenTreasure = false
                        manager.showingAnswer = false
                    }
                    
                    disableTap()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                    
                    VStack {
                        if manager.currentIsHiddenTreasure {
                            Text("Hidden Treasue!")
                                .font(.custom("Arial Rounded MT Bold", size: 24))
                                .bold()
                                .foregroundColor(.white)
                                .colorMultiply(manager.hiddenTreasureColor)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                        manager.hiddenTreasureColor = Color(red: 232 / 255, green: 201 / 255, blue: 26 / 255)
                                    }
                                }
                                .padding(.top, 30)
                        }
                        
                        Text(manager.currentQuestion!.text)
                            .font(.custom("Arial Rounded MT Bold", size: 24))
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .padding(30)
                        
                        Spacer()
                        
                        Text(manager.currentQuestion!.answer)
                            .font(.custom("Arial Rounded MT Bold", size: 24))
                            .bold()
                            .foregroundColor(.white)
                            .opacity(manager.showingAnswer ? 1 : 0.5)
                            .padding(10)
                        
                        Text(manager.currentQuestion!.points == 1 ? "1  talent" : "\(manager.currentQuestion!.points)  talents")
                            .font(.custom("Arial Rounded MT Bold", size: 16))
                            .bold()
                            .foregroundColor(.white)
                            .opacity(manager.showingAnswer ? 1 : 0.5)
                            .padding(.bottom, 30)
                    }
                }
                .aspectRatio(3 / 2, contentMode: .fit)
                .padding()
            })
            .buttonStyle(.plain)
        }
    }
    
    func disableTap() {
        tapDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tapDisabled = false
        }
    }
}

#Preview {
    ManagerGameBoardView(categories: [.angelsAndDemons1, .beforeIsrael, .bibleQuotes, .booksOfTheBible1, .creation, .davidAndSolomon])
}
