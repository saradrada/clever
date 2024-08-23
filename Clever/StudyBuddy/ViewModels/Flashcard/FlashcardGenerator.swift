//
//  FlashcardGenerator.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 01.07.23.
//

import Foundation

class FlashcardGenerator {
    func generateFlashcards(courseId: String, files: [String], flashcardsPerFile: Int = 3, completion: @escaping (Result<[Flashcard], Error>) -> Void) {
        let urlString = "\(EnvironmentVariables.API.base.rawValue)/flashcards/generate"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "course_id": courseId,
            "files": files,
            "flashcards_per_file": flashcardsPerFile
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data", code: 0, userInfo: nil)))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON string: \(jsonString)")
            }

            do {
                let flashcardResponse = try JSONDecoder().decode(FlashcardResponse.self, from: data)
                completion(.success(flashcardResponse.flashCards))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }


    func getFlashcards(courseId: String, completion: @escaping (Result<[Flashcard], Error>) -> Void) {
        let urlString = "\(EnvironmentVariables.API.base.rawValue)/flashcards?course_id=\(courseId)"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data", code: 0, userInfo: nil)))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON string: \(jsonString)")
            }

            do {
                let flashcards = try JSONDecoder().decode([Flashcard].self, from: data)
                completion(.success(flashcards))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    
//    func getFlashcards(courseId: String, completion: @escaping (Result<[Flashcard], Error>) -> Void) {
//        let urlString = "\(EnvironmentVariables.API.base.rawValue)/flashcards?course_id=\(courseId)"
//
//        guard let url = URL(string: urlString) else {
//            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//            completion(.failure(error))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                let error = NSError(domain: "Invalid Data", code: 0, userInfo: nil)
//                completion(.failure(error))
//                return
//            }
//
//            do {
//                let flashcards = try JSONDecoder().decode([Flashcard].self, from: data)
//                completion(.success(flashcards))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//
//        task.resume()
//    }



    private func buildQueryParams(parameter: String) -> String {
        let encodedParameter = parameter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedParameter!
    }

}
