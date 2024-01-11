//
//  Exodus.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/24/22.
//

extension Category {
    static let exodus = Category(
        "Exodus",
        questions: [
            Question(
                "Moses helped the Israelites escape from slavery in this country.",
                answer: "What is Egypt?",
                points: 1),
            Question(
                "The Israelites crossed through this sea to escape the Egyptians.",
                answer: "What is the Red Sea?",
                points: 2),
            Question(
                "This man was Moses' brother.",
                answer: "Who was Aaron?",
                points: 3),
            Question(
                "The Israelites did this while Moses was on Mount Sinai recieving the Ten Commandments from God.",
                answer: "What is worshipping a golden calf?",
                points: 4),
            Question(
                "The Israelites wandered in the wilderness for this many years.",
                answer: "What is 40?",
                points: 5)
        ]
    )
}
