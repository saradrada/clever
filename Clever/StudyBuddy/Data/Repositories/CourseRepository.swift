//
//  CourseRepository.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 03.12.23.
//

import Foundation

protocol CourseRepository {
    func createCourse(course: Course, completion: @escaping (Result<Course, Error>) -> Void)
}
