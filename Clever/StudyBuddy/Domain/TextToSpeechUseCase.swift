//
//  TextToSpeechUseCase.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 28.11.23.
//

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
