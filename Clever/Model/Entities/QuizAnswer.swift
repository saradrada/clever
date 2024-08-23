//
//  QuizAnswer.swift
//  Clever

import Foundation

struct QuizAnswer: Codable {
    let text: String
    let questionary: [Question]
}

struct Question: Codable, Hashable {
    let question: String
    let options: [String]
    let answer: String
}
