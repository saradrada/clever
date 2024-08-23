//
//  CourseFileManager.swift
//  Clever

import Foundation

class CourseFileManager {
    private let coursesFileName = "courses.json"
    
    func saveCourses(data: Data) {
        guard let fileURL = getFileURL() else {
            return
        }
        
        do {
            try data.write(to: fileURL)
            
        } catch {
        }
    }
    
    func loadCourses() -> Data? {
        guard let fileURL = getFileURL() else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            return nil
        }
    }
    
    private func getFileURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(coursesFileName)
        return fileURL
    }
}
