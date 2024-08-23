//
//  QuestionAnswer.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 03.07.23.
//

import Foundation

struct QuestionAnswer: Codable, Identifiable {
    var id: UUID? = UUID()
    let question: String
    let answer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case question = "question"
        case answer = "answer"
    }
}

struct QuestionAnswerResponse: Codable {
    var questions: [QuestionAnswer]
}
