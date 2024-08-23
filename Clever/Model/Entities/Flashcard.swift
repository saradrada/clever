//
//  FlashCard.swift
//  Clever

import Foundation

struct Flashcard: Codable, Identifiable {
    var id: String?
    let front: String
    let back: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case front
        case back
    }
}

struct FlashcardResponse: Codable {
    var flashCards: [Flashcard]

    enum CodingKeys: String, CodingKey {
        case flashCards = "flash_cards"
    }
}
