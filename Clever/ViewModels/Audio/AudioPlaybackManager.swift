//
//  AudioPlaybackManager.swift
//  Clever

import AVFoundation

class AudioPlaybackManager {
    static let shared = AudioPlaybackManager()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playSound(from url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Audio playback error: \(error)")
        }
    }
}
