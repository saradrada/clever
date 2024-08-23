//
//  SpeechRepository.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 28.11.23.
//

import Foundation

protocol SpeechRepository {
    func fetchSpeech(fromText text: String, completion: @escaping (Result<Speech, Error>) -> Void)
}
