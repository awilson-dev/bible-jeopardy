//
//  BibleQuotes.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/24/22.
//

extension Category {
    static let bibleQuotes = Category(
        "Bible Quotes",
        questions: [
            Question(
                "A \"soft answer turns away...\" this particular thing.",
                answer: "What is wrath?",
                points: 1),
            Question(
                "Proverbs says, \"Go to (this animal), you sluggard! consider her ways and be wise.\"",
                answer: "What is an ant?",
                points: 2),
            Question(
                "In His sermon on the mount, the house Jesus described fell because it was built on this thing.",
                answer: "What is sand?",
                points: 3),
            Question(
                "Jesus was teaching about this thing when he said, \"Therefore what God has joined together, let not man separate.\"",
                answer: "What is marriage?",
                points: 4),
            Question(
                "This plant is \"the least of all seeds,\" but when it is grown, it is \"the greatest among herbs.\"",
                answer: "What is the mustard plant?",
                points: 5)
        ]
    )
}
