//
//  FileListView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

import SwiftUI

struct FileListView: View {
    @ObservedObject var courseViewModel: CourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Selected Files")
                .font(.subheadline)
                .padding(.bottom, 5)

            ForEach(courseViewModel.files, id: \.id) { file in
                Text(file.name)
                    .padding(.vertical, 2)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}


#Preview {
    FileListView(courseViewModel: CourseViewModel())
}
