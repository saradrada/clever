//
//  FlashcardView.swift
//  Clever

import SwiftUI

struct FlashcardView: View {
    
    let flashcard: Flashcard
    let viewModel: FlashcardViewModel

    @State var flipped = false
    @State var rotation: CGFloat = 0
    
    var body: some View {
        ZStack {
            FrontCardView(flashcard: flashcard, viewModel: viewModel)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                .opacity(flipped ? 0 : 1)
            BackCardView(flashcard: flashcard, viewModel: viewModel)
                .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
                .opacity(flipped ? 1 : 0)
        }
        .onTapGesture {
            flip()
        }
        .padding()
    }
    
    func flip() {
        let secondTurn = FlipAnimation(duration: 0.15, next: nil) {
            rotation += 90
        }
        let flipViews = FlipAnimation(duration: 0.01, next: secondTurn) {
            flipped.toggle()
        }
        let firstTurn = FlipAnimation(duration: 0.15, next: flipViews) {
            rotation += 90
        }
        firstTurn.play()
    }
}

#Preview {
    FlashcardView(flashcard: Flashcard(id: "123", front: "Which has a greater quantity, the number of stars in the universe or the grains of sand on all the beaches on Earth?", back: "There are more stars in the universe than grains of sand on all the beaches on Earth."), viewModel: FlashcardViewModel())
}


