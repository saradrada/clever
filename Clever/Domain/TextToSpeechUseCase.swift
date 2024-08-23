//
//  TextToSpeechUseCase.swift
//  Clever

import Foundation

class TextToSpeechUseCase {
    private let repository: SpeechRepository

    init(repository: SpeechRepository) {
        self.repository = repository
    }

    func execute(text: String, completion: @escaping (Result<Speech, Error>) -> Void) {
        repository.fetchSpeech(fromText: text, completion: completion)
    }
}
