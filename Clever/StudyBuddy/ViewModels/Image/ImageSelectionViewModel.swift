//
//  ImageSelectionViewModel.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

class ImageSelectionViewModel: ObservableObject {

    // MARK: - getURL

   func getURL(item: PhotosPickerItem, completionHandler: @escaping (_ result: Result<URL, Error>) -> Void) {
       // Step 1: Load as Data object.
       item.loadTransferable(type: Data.self) { result in
           switch result {
           case .success(let data):
               if let contentType = item.supportedContentTypes.first {
                   // Step 2: make the URL file name and a get a file extention.
                   let url = self.getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")")
                   if let data = data {
                       do {
                           // Step 3: write to temp App file directory and return in completionHandler
                           try data.write(to: url)
                           completionHandler(.success(url))
                       } catch {
                           completionHandler(.failure(error))
                       }
                   }
               }
           case .failure(let failure):
               completionHandler(.failure(failure))
           }
       }
   }

   /// from: https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory
   func getDocumentsDirectory() -> URL {
       // find all possible documents directories for this user
       let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

       // just send back the first one, which ought to be the only one
       return paths[0]
   }
}
