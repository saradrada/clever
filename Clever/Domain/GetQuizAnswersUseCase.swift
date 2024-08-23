//
//  GetQuizAnswersUseCase.swift
//  Clever

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
