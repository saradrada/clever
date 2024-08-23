//
//  SolveQuizView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 06.12.23.
//

import SwiftUI
import PhotosUI

struct SolveQuizView: View {

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var isUploadingImage: Bool = true

    @ObservedObject var courseViewModel: CourseViewModel

    var course: Course

    var body: some View {

        ScrollView {
            VStack(spacing: 10) {
                headerSection

                VStack(alignment: .center) {
                    if let avatarImage {
                        avatarImage
                            .resizable()
                            .scaledToFit()
                            .background(.red)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                            .shadow(radius: 10)

                    }
                    uploadQuizButton
                    solveQuizButton
                    questionarySection
                }
            }
        }
    }

}

extension SolveQuizView {
    private var headerSection: some View {
        VStack {
            Image("solve-quiz")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 200)

            Text("Upload your quiz and unlock instant solutions! Simply snap a picture of your quiz, and let our app guide you to the correct answers effortlessly.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.bottom)
        }
    }

    private var questionarySection: some View {
        VStack(alignment: .center) {
            ForEach(courseViewModel.questionary, id: \.self) { q in
                QuestionaryCardView(courseViewModel: courseViewModel, question: q)
                    .frame(width: 350)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var solveQuizButton: some View {
        Button {
            if let avatarItem = avatarItem, let courseId = course.course_id {
                courseViewModel.getQuizAnswers(fromImage: avatarItem, courseId: courseId)
            }

        } label: {
            if courseViewModel.isImageFileLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                HStack {
                    Image(systemName: "questionmark.app")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                    Text("Solve it")
                }
            }
        }
        .uploadButton(backgroundColor: isUploadingImage ? .gray : Color ("Purple Text"), textColor: .white)
//        .uploadButton(backgroundColor: (courseViewModel.isUploadingImage || courseViewModel.isImageFileLoading) ? .gray : Color ("Purple Background"), textColor: (courseViewModel.isUploadingImage || courseViewModel.isImageFileLoading) ? .white : Color("Purple Text"))
        .disabled(isUploadingImage ? true : false)
//        .disabled((courseViewModel.isUploadingImage || courseViewModel.isImageFileLoading) ? true : false)
        .padding(.horizontal, 30)

    }
    private var uploadQuizButton: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 18)
            PhotosPicker("Upload Quiz", selection: $avatarItem, matching: .images)

        }
        .uploadButton()
        .padding(.horizontal, 30)
        .onChange(of: avatarItem) {_ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)

                        isUploadingImage = false

                        return
                    }
                }
                print("Failed")
            }
        }
    }
}

#Preview {
    SolveQuizView(courseViewModel: CourseViewModel(), course: Course(id: UUID(), title: "Course Title", subject: "Subject", filesIds: ["1", "2"], icon: "house", questions: [QuestionAnswer(id: UUID(), question: "Question", answer: "Answer")], files: [File(id: UUID(), name: "File Name", type: "pdf", file_id: "3")]))
}
