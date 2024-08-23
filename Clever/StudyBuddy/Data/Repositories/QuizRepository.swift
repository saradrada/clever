//
//  QuizRepository.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

import Foundation

protocol QuizRepository {
    func ask(withImage: URL, courseId: String, completion: @escaping (Result<QuizAnswer, Error>) -> Void)
}
