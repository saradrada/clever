//
//  FlashcardListView.swift
//  Clever

import SwiftUI

struct FlashcardListView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.flashcards) { flashcard in
                FlashcardRowView(flashcard: flashcard, viewModel: viewModel)
            }
            .navigationBarTitle("Flashcards")
        }
    }
}

struct FlashcardRowView: View {
    let flashcard: Flashcard
    let viewModel: FlashcardViewModel

    var body: some View {
        VStack(alignment: .leading) {
            FlashcardView(flashcard: flashcard, viewModel: viewModel)
        }
    }
}

struct FlashcardListView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardListView(viewModel: FlashcardViewModel())
    }
}
