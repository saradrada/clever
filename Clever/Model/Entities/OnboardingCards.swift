//
//  OnboardingCard.swift
//  Clever

import Foundation

public enum OnboardingCards: String, CaseIterable, Identifiable {
    case one
    case two
    case three
    case four
    case five

    public var id: String { self.rawValue }

    var title: String {
        switch self {
        case .one:
            "Welcome to Clever"
        case .two:
            "Snap & Learn"
        case .three:
            "Flashcards in a Tap"
        case .four:
            "Quiz Solved, Stress Resolved"
        case .five:
            "Study with Text-to-Speech"
        }
    }

    var description: String {
            switch self {
            case .one:
                return "Elevate your learning with AI-powered tools designed to help you study smarter and achieve more."
            case .two:
                return "Capture or upload materials, and get instant answers to all your study questions."
            case .three:
                return "Convert your study materials into effective flashcards with just one tap."
            case .four:
                return "Take a picture of any quiz, and let Study Buddy find the answers for you."
            case .five:
                return "Listen to your study materials anytime, anywhere, making learning seamless."
            }
        }

        var imageName: String {
            switch self {
            case .one:
                return "one"
            case .two:
                return "two"
            case .three:
                return "three"
            case .four:
                return "four"
            case .five:
                return "five"
            }
        }
}
