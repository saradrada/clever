//
//  PDFDocument.swift
//  Clever

import Foundation

struct PDFDocument: Identifiable, Codable {
    var id: UUID
    let name: String
    let url: URL
}
