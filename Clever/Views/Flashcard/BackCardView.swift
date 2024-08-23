//
//  BackCardView.swift
//  Clever

import SwiftUI

struct BackCardView: View {
    let flashcard: Flashcard
    let viewModel: FlashcardViewModel
    @StateObject var textToSpeechViewModel = TextToSpeechViewModel()

    init(flashcard: Flashcard, viewModel: FlashcardViewModel) {
        self.flashcard = flashcard
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Answer:")
                .textCase(.uppercase)
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text(flashcard.back)
                .font(.callout)
            Spacer()
            HStack(alignment: .bottom) {
                Button {
                    if let text = getCurrentFlashcardText() {
                        textToSpeechViewModel.fetchSpeech(fromText: text)
                    }
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundStyle(Color("Purple Primary"))
                }
                .disabled(viewModel.isLoading)
                Spacer()
                Image(systemName: "arrow.2.squarepath")
                    .foregroundStyle(Color("Purple Background"))
            }
            .font(.title)
        }
        .padding(30)
        .card()
    }

    private func getCurrentFlashcardText() -> String? {
        self.flashcard.back
    }

    private func playSpeechAudio(_ speechData: Speech?) {
        // Logic to play the speech audio
    }
}
//
//#Preview {
//    BackCardView(flashcard: Flashcard(front: "", back: "Ozono protects the Earth from harmful ultraviolet (UV) rays from the Sun.\n\nWithout the Ozone layer in the atmosphere, life on Earth ould be very difficult.\n\nPlants cannot live and grow in heavy ultraviolet radiation, nor can the planktons that serve as food for most of the ocean life."), viewModel: FlashcardViewModel())
//}
