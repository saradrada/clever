//
//  GetQuizAnswersUseCase.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

import Foundation

class GetQuizAnswersUseCase {
    private let repository: QuizRepository

    init(repository: QuizRepository) {
        self.repository = repository
    }

    func execute(withImage: URL, courseId: String, completion: @escaping (Result<QuizAnswer, Error>) -> Void) {
        repository.ask(withImage: withImage, courseId: courseId, completion: completion)
    }
}
