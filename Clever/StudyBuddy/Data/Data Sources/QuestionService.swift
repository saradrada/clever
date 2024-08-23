//
//  QuestionService.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 04.12.23.
//

import Foundation

class QuestionService: QuestionRepository {
    
    func getQuestions(courseId: String, completion: @escaping (Result<[QuestionAnswer], Error>) -> Void) {
        guard let url = URL(string: "http://34.16.129.70:8000/question?course_id=\(courseId)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            print(String(data: data, encoding: .utf8) ?? "Invalid data")

            do {
                let questions = try JSONDecoder().decode([QuestionAnswer].self, from: data)
                completion(.success(questions))
            } catch {
                completion(.failure(error))
            }

        }
        task.resume()
    }


    func ask(question: String, files: [String], courseId course_id: String, completion: @escaping (Result<QuestionAnswer, Error>) -> Void) {
        let url = URL(string: "http://34.16.129.70:8000/question/ask")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "question": question,
            "files": files,
            "course_id": course_id
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "NetworkError", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP error with status code \(statusCode)"])
                completion(.failure(error))
                return
            }

            do {
                let response = try JSONDecoder().decode(QuestionAnswer.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }


}
