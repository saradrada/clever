//
//  QuestionListView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 03.07.23.
//

import SwiftUI

struct QuestionListView: View {
    @State private var value: Double = 0
    @State var question: String = ""

    @State private var showingFileSelector = false
    @State var selectedFiles: [File]
    @State var selectedFilesIds: [String]

    @ObservedObject var courseViewModel: CourseViewModel

    @State private var allFiles: Bool = true

    var course: Course

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image("questions")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 225)

                Text("Get answers from your files! Ask and receive expert guidance from your Studdy Buddy.")
                    .font(.subheadline)
                    .foregroundColor(.gray)


                VStack(alignment: .leading) {
                    TextField("Add your question", text: $question)
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 13)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineLimit(5)
                        .disabled(courseViewModel.isLoadingQuestions)

                    Toggle(isOn: $allFiles) {
                        HStack {
                            Text("Select all files")
                                .font(.subheadline)

                        }
                    }
                    .padding(.horizontal, 4)
                    .toggleStyle(SwitchToggleStyle(tint: Color("Purple Text")))

                    .onChange(of: allFiles) { newValue in
                        if newValue {
                            selectedFiles = course.files
                        } else {
                            // If you want to clear the selection when the toggle is off, uncomment the following line
                            // selectedFiles = []
                        }
                    }

                    if allFiles {
                        allFilesSection
                    } else {
                        if !selectedFiles.isEmpty {
                            selectedFilesSection
                        }
                    }

                    HStack{
                        selectFilesButton
                            .disabled(allFiles)
                        askQuestionButton
                    }
                        .padding(.top, 5)


                }
                .padding()

                VStack {
                    if courseViewModel.isLoadingQuestions {
                        ProgressView()
                    }
                    ForEach(Array(courseViewModel.questions.enumerated().reversed()), id: \.offset) { index, question in
                        QuestionAnswerCardView(question: question.question, answer: question.answer)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                Spacer()
            }
            .navigationTitle("Ask your Buddy")
        }
    }
}

extension QuestionListView {
    private var selectedFilesSection: some View {
        ScrollView {
            HStack {
                ForEach(selectedFiles, id: \.self) { file in
                    FileCard(file: file, editable: true) {
                        if let index = selectedFiles.firstIndex(of: file) {
                            selectedFiles.remove(at: index)
                            if selectedFiles.count < course.files.count {
                                allFiles = false
                            }
                        }
                    }
                    .padding(.horizontal, 3)
                }
            }
        }
    }

    private var allFilesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view
            HStack(alignment: .center, spacing: 3) { // HStack inside the ScrollView
                ForEach(course.files, id: \.self) { file in
                    FileCard(file: file, editable: false) {

                    }
                        .padding(.horizontal, 3)
                }
            }
        }
    }


//    private var allFilesSection: some View {
//        HStack(alignment: .center) {
//            ForEach(course.files, id: \.self) { file in
//                HStack {
//                    FileCard(file: file)
//
//                }
//                .padding(.horizontal, 3)
//            }
//        }
//    }

    private var selectFilesButton: some View {
        Button {
            showingFileSelector = true
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("Select Files")
            }
        }
        .uploadButton(backgroundColor: allFiles ? .gray : Color("Purple Background"), textColor: allFiles ? .white : Color("Purple Text"))
        .sheet(isPresented: $showingFileSelector) {
            MultipleSelectionList(items: course.files, initialSelections: selectedFiles) { selectedItems in
                selectedFiles = selectedItems
                allFiles = selectedItems.count == course.files.count ? true : false
                showingFileSelector = false
            }
        }
    }

    private var askQuestionButton: some View {
        Button {
            courseViewModel.ask(question: question, files: selectedFiles.isEmpty ? course.filesIds : courseViewModel.getFileIds(from: selectedFiles), courseId: course.course_id!)
            question = ""
        } label: {
            Text("Ask")
        }
        .uploadButton(backgroundColor: courseViewModel.isLoadingQuestions || question.isEmpty ? .gray : Color("Purple Text"), textColor: .white)
        .fontWeight(.medium)
        .disabled(courseViewModel.isLoadingQuestions || question.isEmpty)
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var previews: some View {
        let course = Course(
            id: UUID(),
            title: "Title",
            subject: "Subject",
            filesIds: [],
            icon: "book.cirlce",
            questions: [],
            files: [])

        let courseViewModel = CourseViewModel()
        QuestionListView(selectedFiles: [], selectedFilesIds: [], courseViewModel: courseViewModel, course: course)
    }
}
