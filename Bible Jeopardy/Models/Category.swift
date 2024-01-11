//
//  Category.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import Foundation

struct Category: Identifiable, Equatable {
    let name: String
    let questions: [Question]
    var displayName: String {
        var displayName = name
        if displayName.last == ")" {
            displayName.removeLast(4)
        }
        return displayName
    }
    
    var id = UUID()
    
    init(_ name: String, questions: [Question]) {
        self.name = name
        self.questions = questions
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name && lhs.questions == rhs.questions
    }
}

extension Category: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        switch value {
        case "angelsAndDemons1":
            self = .angelsAndDemons1
        case "angelsAndDemons2":
            self = .angelsAndDemons2
        case "beforeIsrael":
            self = .beforeIsrael
        case "bibleQuotes":
            self = .bibleQuotes
        case "booksOfTheBible1":
            self = .booksOfTheBible1
        case "booksOfTheBible2":
            self = .booksOfTheBible2
        case "booksOfTheBible3":
            self = .booksOfTheBible3
        case "creation":
            self = .creation
        case "davidAndSolomon":
            self = .davidAndSolomon
        case "endTimes":
            self = .endTimes
        case "exodus":
            self = .exodus
        case "bibleHeroes":
            self = .bibleHeroes
        case "israel1":
            self = .israel1
        case "israel2":
            self = .israel2
        case "lifeOfJesus":
            self = .lifeOfJesus
        case "miracles":
            self = .miracles
        case "nameThatHymn1":
            self = .nameThatHymn1
        case "nameThatHymn2":
            self = .nameThatHymn2
        case "newTestament":
            self = .newTestament
        case "places":
            self = .places
        case "prophecy":
            self = .prophecy
        case "ruth":
            self = .ruth
        case "esther":
            self = .esther
        case "joseph":
            self = .joseph
        case "daniel":
            self = .daniel
        default:
            self.init("", questions: [])
        }
    }
}

enum Categories: Category, Identifiable, CaseIterable {
    case angelsAndDemons1
    case angelsAndDemons2
    case beforeIsrael
    case bibleQuotes
    case booksOfTheBible1
    case booksOfTheBible2
    case booksOfTheBible3
    case creation
    case davidAndSolomon
    case endTimes
    case exodus
    case bibleHeroes
    case israel1
    case israel2
    case lifeOfJesus
    case miracles
    case nameThatHymn1
    case nameThatHymn2
    case newTestament
    case places
    case prophecy
    case ruth
    case esther
    case joseph
    case daniel
    
    var id: Self { self }
    
    static let newCategories: [Categories] = [.ruth, .esther, .joseph, .daniel]
}
