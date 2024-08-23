//
//  FlashcardDeckView.swift
//  Clever

import SwiftUI

struct FlashcardDeckView: View {
    @State private var currentIndex = 0
    @ObservedObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if flashcardViewModel.isLoading {
                    ProgressView()
                } else if flashcardViewModel.flashcards.isEmpty {
                    Text("No flashcards")
                } else {
                    VStack{
                        ProgressBar(value: progress)
                            .frame(height: 15)
                            .padding(.vertical)
                            .padding(.horizontal, 35)
                        
                        ZStack {
                            ForEach(flashcardViewModel.flashcards.indices) { index in
                                FlashcardView(flashcard: flashcardViewModel.flashcards[currentIndex], viewModel: flashcardViewModel)
                                    .zIndex(2)
                                Text("")
                                    .card()
                                    .rotationEffect(.degrees(2))
                                    .zIndex(1)
                                
                                Text("")
                                    .card()
                                    .rotationEffect(.degrees(4))
                                    .zIndex(0)
                            }
                        }
                        .padding(.bottom, 15)
                    }
                    HStack {
                        Button(action: { navigatePrevious() }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .resizable()
                                .arrowButton()
                        }
                        Spacer()
                        Button(action: { navigateNext() }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .arrowButton()

                        }
                    }
                    .padding(.horizontal, 35)
                }
            }
        }
    }
    
    private var progress: Double {
        Double(currentIndex) / Double(flashcardViewModel.flashcards.count - 1)
    }
    
    private func navigateNext() {
        if currentIndex >= flashcardViewModel.flashcards.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    private func navigatePrevious() {
        if currentIndex <= 0 {
            currentIndex = flashcardViewModel.flashcards.count - 1
        } else {
            currentIndex -= 1
        }
    }
}

struct FlashcardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        let flashcardViewModel = FlashcardViewModel()
        let setOfFlashcards = [
            Flashcard(id: "1", front: "Question 1", back: "Answer 1"),
            Flashcard(id: "21", front: "Question 2", back: "Answer 2"),
            Flashcard(id: "13", front: "Question 3", back: "Answer 3"),
            Flashcard(id: "41", front: "Question 4", back: "Answer 4"),
            Flashcard(id: "51", front: "Question 5", back: "Answer 5"),
            Flashcard(id: "12", front: "Question 6", back: "Answer 6"),
            Flashcard(id: "14", front: "Question 7", back: "Answer 7"),
            Flashcard(id: "16", front: "Question 8", back: "Answer 8")
        ]
        flashcardViewModel.flashcards.append(contentsOf: setOfFlashcards)
        return FlashcardDeckView(flashcardViewModel: flashcardViewModel)
    }
}
