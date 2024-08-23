//
//  FlashcardData.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 26.06.23.
//

import Foundation

//class FlashcardData {
//    static func loadFlashcards() -> [Flashcard] {
//        guard let fileURL = Bundle.main.url(forResource: "flashcards", withExtension: "json") else {
//            fatalError("Unable to find flashcards.json file")
//        }
//        
//        do {
//            let jsonData = try Data(contentsOf: fileURL)
//            let flashcards = try JSONDecoder().decode(FlashcardResponse.self, from: jsonData).flashcards
//            return flashcards
//        } catch {
//            fatalError("Error parsing flashcards.json: \(error)")
//        }
//    }
//}
