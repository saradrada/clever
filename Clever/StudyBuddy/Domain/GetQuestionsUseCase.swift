//
//  GetQuestionsUseCase.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 04.12.23.
//

import Foundation

class GetQuestionsUseCase {
    private let repository: QuestionRepository

    init(repository: QuestionRepository) {
        self.repository = repository
    }

    func execute(courseId: String, completion: @escaping (Result<[QuestionAnswer], Error>) -> Void) {
        repository.getQuestions(courseId: courseId, completion: completion)
    }
}
