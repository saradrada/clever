//
//  UploadPDFCardView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 02.12.23.
//

import SwiftUI

struct UploadPDFCardView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    @Binding private var presentImporter: Bool
    @Binding private var presentFileImporter: Bool
    @Binding private var isDocumentSelected: Bool

    public init(presentImporter: Binding<Bool>, isDocumentSelected: Binding<Bool>, presentFileImporter: Binding<Bool>, courseViewModel: CourseViewModel) {
        self._presentImporter = presentImporter
        self._isDocumentSelected = isDocumentSelected
        self._presentFileImporter = presentFileImporter
        self.courseViewModel = courseViewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Select Files")
                    .font(.headline)

            }
            .padding(.top)
            .padding(.horizontal)

            Text(UploadPDFCard.description.rawValue)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            VStack {
                
                if !courseViewModel.filesNames.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(courseViewModel.filesNames, id: \.self) { fileName in
                            HStack {
                                Text(fileName)
                                    .padding(.vertical, 2)
                                Spacer()
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.green)
                            }
                            .padding(.bottom, 3)
                        }
                    }
                    .padding(.horizontal)
                }
                
                
                Button {
                    presentImporter = true
                } label: {
                    if courseViewModel.isCreatingFile {
                        ProgressView()
                    } else {
                        HStack(alignment: .center) {
                            Image(systemName: "square.and.arrow.up")
                            Text("Select Files")
                        }
                    }
                }
                .uploadButton()
                .padding(.horizontal)
                .disabled(courseViewModel.isCreatingFile)
                .fileImporter(
                    isPresented: $presentImporter,
                    allowedContentTypes: [.pdf, .commaSeparatedText, .image, .audio]) { result in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                    switch result {
                    case .success(let url):
                        courseViewModel.handlePickedPDF(at: url)
                        isDocumentSelected = true
                    case .failure(_):
                        isDocumentSelected = true
                    }
                }

//                Button {
//                    presentImporter = true
//                } label: {
//                    HStack(alignment: .center) {
//                        Image(systemName: "photo")
//                        Text("Select Images")
//                    }
//                }
//                .uploadButton()
//                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal, 30)

    }
}

#Preview {
    @State var presentImporter = false
    @State var isDocumentSelected = false
    @State var presentFileImporter = false

    return UploadPDFCardView(
        presentImporter: $presentImporter,
        isDocumentSelected: $isDocumentSelected,
        presentFileImporter: $presentFileImporter,
        courseViewModel: CourseViewModel()
    )
}
