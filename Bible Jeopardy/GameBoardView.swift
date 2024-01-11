//
//  GameBoardView.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import SwiftUI

struct GameBoardView: View {
    @StateObject var settings = GameSettings.shared
    
    var categories: [Categories]
    
    @State private var currentQuestion: Question? = nil
    @State private var showingAnswer: Bool = false
    @State private var completed = Array(repeating: Array(repeating: false, count: 5), count: 6)
    
    var hiddenTreasureX = Int.random(in: 0 ..< 6)
    let hiddenTreasureY = Int.random(in: 0 ..< 5)
    @State private var hiddenTreasure = Array(repeating: Array(repeating: false, count: 5), count: 6)
    @State private var currentIsHiddenTreasure = false
    @State private var hiddenTreasureColor: Color = Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
    
    init(categories: [Categories]) {
        self.categories = categories
        
        completed = Array(repeating: Array(repeating: false, count: 5), count: settings.categoryCount)
        hiddenTreasureX = Int.random(in: 0 ..< settings.categoryCount)
        hiddenTreasure = Array(repeating: Array(repeating: false, count: 5), count: settings.categoryCount)
    }
    
    var body: some View {
        if currentQuestion == nil {
            HStack {
                ForEach(categories) { category in
                    VStack {
                        VStack {
                            Text(category.rawValue.displayName)
                                .font(.custom("Arial Rounded MT Bold", size: 24))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(height: 60)
                        ForEach(category.rawValue.questions) { question in
                            let x = categories.firstIndex(of: category)!
                            let y = category.rawValue.questions.firstIndex(of: question)!
                            
                            Button(action: {
                                currentQuestion = question
                                if hiddenTreasure[x][y] {
                                    currentIsHiddenTreasure = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        SoundManager.shared.play("achievementChime", in: 1)
                                    }
                                }
                                if question.hymn != nil {
                                    SoundManager.shared.play(question.hymn!.rawValue)
                                }
                                completed[x][y] = true
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                                    if !completed[x][y] {
                                        Text(question.points == 1 ? "\(question.points)  talent" : "\(question.points)  talents")
                                            .font(.custom("Arial Rounded MT Bold", size: 20))
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                }
                            })
                                .disabled(completed[x][y])
                        }
                    }
                }
            }
            .aspectRatio(3 / 2, contentMode: .fit)
            .padding()
            .onAppear {
                if settings.hiddenTreasureEnabled {
                    hiddenTreasure[hiddenTreasureX][hiddenTreasureY] = true
                }
            }
        } else {
            Button(action: {
                if !showingAnswer {
                    showingAnswer = true
                } else {
                    SoundManager.shared.stopSmoothly(duration: 0.5)
                    currentQuestion = nil
                    currentIsHiddenTreasure = false
                    showingAnswer = false
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(red: 11 / 255, green: 37 / 255, blue: 191 / 255))
                    VStack {
                        if currentIsHiddenTreasure {
                            Text("Hidden Treasue!")
                                .font(.custom("Arial Rounded MT Bold", size: 36))
                                .bold()
                                .foregroundColor(.white)
                                .colorMultiply(hiddenTreasureColor)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                        hiddenTreasureColor = Color(red: 232 / 255, green: 201 / 255, blue: 26 / 255)
                                    }
                                }
                                .padding(.top, 30)
                        }
                        Text(currentQuestion!.text)
                            .font(.custom("Arial Rounded MT Bold", size: 36))
                            .bold()
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .padding(30)
                        Spacer()
                        if showingAnswer {
                            Text(currentQuestion!.answer)
                                .font(.custom("Arial Rounded MT Bold", size: 36))
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                            Text(currentQuestion!.points == 1 ? "1  talent" : "\(currentQuestion!.points)  talents")
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.bottom, 30)
                        }
                    }
                }
                .aspectRatio(3 / 2, contentMode: .fit)
                .padding()
            })
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(categories: [.beforeIsrael, .bibleQuotes, .booksOfTheBible1, .creation, .davidAndSolomon])
            .background(Color.black)
    }
}
