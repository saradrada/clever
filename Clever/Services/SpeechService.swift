//
//  SpeechService.swift
//  Clever

import Foundation

protocol SpeechRepository {
    func fetchSpeech(fromText text: String, completion: @escaping (Result<Speech, Error>) -> Void)
}


class SpeechService: SpeechRepository {
    func fetchSpeech(fromText text: String, completion: @escaping (Result<Speech, Error>) -> Void) {
        let urlString = "\(EnvironmentVariables.API.base.rawValue)/text-to-speech?message=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid response", code: -2, userInfo: nil)))
                return
            }

            guard let mimeType = httpResponse.mimeType, mimeType == "audio/wav", let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: -3, userInfo: nil)))
                return
            }

            do {
                let fileURL = try self.save(data: data)
                let speech = Speech(audioURL: fileURL)
                completion(.success(speech))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    private func save(data: Data) throws -> URL {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent("speech.wav")

        try data.write(to: fileURL)
        return fileURL
    }
}
