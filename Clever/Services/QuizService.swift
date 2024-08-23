//
//  QuizService.swift
//  Clever

import Foundation

protocol QuizRepository {
    func ask(withImage: URL, courseId: String, completion: @escaping (Result<QuizAnswer, Error>) -> Void)
}

class QuizService: QuizRepository {
    func ask(withImage imageURL: URL, courseId: String, completion: @escaping (Result<QuizAnswer, Error>) -> Void) {
        let urlString = "\(EnvironmentVariables.API.base.rawValue)/question/ask-with-image?course_id=\(courseId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.timeoutInterval = 180

        // Create the multipart/form-data body
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Append the file part only
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(imageURL.lastPathComponent)\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        if let fileData = try? Data(contentsOf: imageURL) {
            body.append(fileData)
        } else {
            completion(.failure(NSError(domain: "Invalid File", code: 0, userInfo: nil)))
            return
        }
        body.append("\r\n")

        // End of the body
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            do {
                let quizAnswer = try JSONDecoder().decode(QuizAnswer.self, from: data)
                completion(.success(quizAnswer))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
