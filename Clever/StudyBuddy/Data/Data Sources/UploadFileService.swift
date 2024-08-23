//
//  UploadFileService.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 01.12.23.
//

import Foundation

struct File: Codable, Identifiable, Hashable {
    var id: UUID?
    var name: String
    var type: String
    var file_id: String
}

struct FileResponse: Codable {
    let file_id: String
    var name: String
    let type: String
}

class UploadFileService {

    func uploadFile(pdfURL: URL, completion: @escaping (Result<File, Error>) -> Void) {

        var request = URLRequest(url: URL(string: "\(EnvironmentVariables.API.base.rawValue)/file")!)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(pdfURL.lastPathComponent)\"\r\n")
        body.append("Content-Type: application/pdf\r\n\r\n")
        body.append(try! Data(contentsOf: pdfURL))
        body.append("\r\n")

        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        // Perform the request
        URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in
            // Handle response here
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("Response String: \(responseString ?? "nil")")
            
            do {
                let response = try JSONDecoder().decode(FileResponse.self, from: data)
                let file = File(
                    id: UUID(),
                    name: response.name,
                    type: response.type,
                    file_id: response.file_id
                )
                completion(.success(file))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }

        }.resume()
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
