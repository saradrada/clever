//
//  PageFinderGenerator.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 06.07.23.
//

import Foundation

class PageFinderGenerator {
    
    func findPageFor(indexName index_name: String, query: String, numberOfResponses: Int = 4, completion: @escaping (Result<[PageFinder], Error>) -> Void) {
        
        let numberOfResponsesAsText = "\(numberOfResponses)"
        let queryParam = buildQueryParams(parameter: query)
        let numberOfResponsesParam = buildQueryParams(parameter: numberOfResponsesAsText)
        let urlString = "\(EnvironmentVariables.API.base.rawValue)/search-document/\(index_name)?query=\(queryParam)&n_results=\(numberOfResponsesParam)"
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.timeoutInterval = .infinity
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Invalid Data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                var pageFinderArray = try JSONDecoder().decode([PageFinder].self, from: data)
                pageFinderArray = pageFinderArray.map { var pageFinder = $0; pageFinder.id = UUID(); return pageFinder }
                completion(.success(pageFinderArray))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func buildQueryParams(parameter: String) -> String {
        let encodedParameter = parameter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedParameter!
    }
}
