//
//  QuestionRepository.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 04.12.23.
//

import Foundation

protocol QuestionRepository {
    func ask(question: String, files: [String], courseId: String, completion: @escaping (Result<QuestionAnswer, Error>) -> Void)
    func getQuestions(courseId: String, completion: @escaping(Result<[QuestionAnswer], Error>) -> Void)
}

