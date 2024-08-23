//
//  TextToSpeechViewModel.swift
//  Clever

import Foundation
import AVFoundation

class TextToSpeechViewModel: ObservableObject {
    private var textToSpeechUseCase: TextToSpeechUseCase
    private var audioPlayer: AVAudioPlayer?

    @Published var speechData: Speech?

    init() {
        self.textToSpeechUseCase = TextToSpeechUseCase(repository: SpeechService())
    }

    func fetchSpeech(fromText text: String) {
        print(text)
        textToSpeechUseCase.execute(text: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let speech):
                    self?.speechData = speech

                    self?.playSound(from: speech.audioURL)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func playSound(from url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Audio playback error: \(error)")
        }
    }
}

