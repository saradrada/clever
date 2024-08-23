//
//  PDFDocument.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 25.06.23.
//

import Foundation

struct PDFDocument: Identifiable, Codable {
    var id: UUID
    let name: String
    let url: URL
}
