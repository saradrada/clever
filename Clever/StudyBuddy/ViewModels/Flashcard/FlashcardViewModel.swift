//
//  FlashcardViewModel.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 26.06.23.
//

import Foundation

class FlashcardViewModel: ObservableObject {
    @Published var flashcards: [Flashcard] = []
    @Published var isLoading: Bool = false
    @Published var speechData: Speech?

    private let flashcardGenerator = FlashcardGenerator()
    private let textToSpeechUseCase: TextToSpeechUseCase

    var onError: ((Error) -> Void)?
    var onSpeechDataFetched: (() -> Void)?

    init() {
        self.textToSpeechUseCase = TextToSpeechUseCase(repository: SpeechService())
    }


    func generateFlashcards(courseId: String, files: [String]) {
        isLoading = true
        flashcardGenerator.generateFlashcards(courseId: courseId, files: files) { result in
            switch result {
            case .success(let flashcards):
                DispatchQueue.main.async {
                    self.flashcards = flashcards
                    self.isLoading = false
                }
            case .failure(_):
                self.isLoading = false
            }
        }
    }
    
    func getFlashcards(course: Course) {
    isLoading = true
        if let courseId = course.course_id {
            flashcardGenerator.getFlashcards(courseId: courseId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let flashcards):
                        if !flashcards.isEmpty {
                            self.flashcards = flashcards
                            self.isLoading = false
                        } else {
                            self.generateFlashcards(courseId: courseId, files: course.filesIds)
                        }


                    case .failure( _):
                        self.isLoading = false
                    }
                }
            }
        }
    }

    func fetchSpeech(fromText text: String) {
        print(text)
        textToSpeechUseCase.execute(text: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let speech):
                    self?.speechData = speech
                    self?.onSpeechDataFetched?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
