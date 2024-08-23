//
//  QuestionAnswer.swift
//  Clever

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
