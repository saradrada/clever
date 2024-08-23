//
//  AskQuestionUseCase.swift
//  Clever

import Foundation

class AskQuestionUseCase {
    private let repository: QuestionRepository

    init(repository: QuestionRepository) {
        self.repository = repository
    }

    func execute(question: String, files: [String], courseId: String, completion: @escaping (Result<QuestionAnswer, Error>) -> Void) {
        repository.ask(question: question, files: files, courseId: courseId, completion: completion)
    }
}
