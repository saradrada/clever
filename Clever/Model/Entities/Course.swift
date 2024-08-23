//
//  Course.swift
//  Clever

import Foundation

struct Course: Codable, Identifiable {
    var id: UUID
    var title: String
    var subject: String
    var filesIds: [String]
    var icon: String
    var questions: [QuestionAnswer]
    var course_id: String?
    var files: [File]

    init(id: UUID, title: String, subject: String, filesIds: [String], icon: String
         , questions: [QuestionAnswer], files: [File]
    ) {
        self.id = id
        self.title = title
        self.subject = subject
        self.filesIds = filesIds
        self.icon = icon
        self.questions = questions
        self.files = files
    }
}

struct CourseCreationResponse: Codable {
    let course_id: String
}
