//
//  CourseService.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 03.12.23.
//

import Foundation

class CourseService: CourseRepository {
    func createCourse(course: Course, completion: @escaping (Result<Course, Error>) -> Void) {
        let url = URL(string: "http://34.16.129.70:8000/course")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "name": course.title,
            "files": course.filesIds
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
                let response = try JSONDecoder().decode(CourseCreationResponse.self, from: data)
                let courseId = response.course_id
                var course = Course(
                    id: course.id,
                    title: course.title,
                    subject: course.subject,
                    filesIds: course.filesIds,
                    icon: course.icon,
                    questions: course.questions,
                    files: course.files
                )
                course.course_id = courseId
                completion(.success(course))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
