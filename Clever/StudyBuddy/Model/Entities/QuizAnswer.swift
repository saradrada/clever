//
//  QuizAnswer.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

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
