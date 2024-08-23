//
//  FrontCardView.swift
//  Clever

import SwiftUI

struct FrontCardView: View {

    let flashcard: Flashcard
    let viewModel: FlashcardViewModel

    @StateObject var textToSpeechViewModel = TextToSpeechViewModel()

    init(flashcard: Flashcard, viewModel: FlashcardViewModel) {
        self.flashcard = flashcard
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Question:")
                .textCase(.uppercase)
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text(flashcard.front)
                .font(.title2)
            
            Spacer()
            HStack(alignment: .bottom) {
                Button {
                    if let text = getCurrentFlashcardText() {
                        textToSpeechViewModel.fetchSpeech(fromText: text)
                    }
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                }
                .disabled(viewModel.isLoading)
                
                Spacer()
                Image(systemName: "arrow.2.squarepath")
            }
            .foregroundStyle(Color("Purple Primary"))
            .font(.title)
        }
        .padding(30)
        .card()
        
    }

    private func getCurrentFlashcardText() -> String? {
        self.flashcard.front
    }

    private func playSpeechAudio(_ speechData: Speech?) {
        // Logic to play the speech audio
    }
}
