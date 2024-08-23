//
//  PageFinder.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 07.07.23.
//

import Foundation

struct PageFinder: Codable, Identifiable {
    var id: UUID?
    let pageContent: String
    let metadata: Metadata
    
    enum CodingKeys: String, CodingKey {
        case pageContent = "page_content"
        case metadata
    }
}

struct Metadata: Codable {
    let pageNumber: Int
    let startIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case startIndex = "start_index"
    }
}
