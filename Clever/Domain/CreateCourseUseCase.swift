//
//  CreateCourseUseCase.swift
//  Clever

import Foundation

class CreateCourseUseCase {
    private let repository: CourseRepository

    init(repository: CourseRepository) {
        self.repository = repository
    }

    func execute(course: Course, completion: @escaping (Result<Course, Error>) -> Void) {
        repository.createCourse(course: course, completion: completion)
    }
}
