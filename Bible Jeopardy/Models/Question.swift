//
//  Question.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import Foundation

struct Question: Identifiable, Equatable {
    let text: String
    let answer: String
    let points: Int
    let hymn: Hymn?
    var isCompleted: Bool = false
    
    var id = UUID()
    
    init(_ text: String, answer: String, points: Int) {
        self.text = text
        self.answer = answer
        self.points = points
        self.hymn = nil
    }
    
    init(hymn: Hymn, answer: String, points: Int) {
        self.text = "Name That Hymn"
        self.answer = answer
        self.points = points
        self.hymn = hymn
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.text == rhs.text && lhs.answer == rhs.answer && lhs.points == rhs.points
    }
}
