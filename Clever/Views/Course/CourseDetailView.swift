//
//  CourseDetailView.swift
//  Clever
//

import SwiftUI

struct CourseDetailView: View {
    @ObservedObject var flashcardViewModel = FlashcardViewModel()
    @ObservedObject var courseViewModel: CourseViewModel
    
    @State var isActive: Bool = false
    @State private var showFlashcardDeckView: Bool = false
    
    var course: Course
    let columns = [
        GridItem(.fixed(170)),
        GridItem(.fixed(170))
    ]
    
    var body: some View {

        a
            .navigationBarTitle(course.title, displayMode: .inline)
    }
}

extension CourseDetailView {

    private var a: some View {
        VStack(spacing: 10) {
                Image("course-detail")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)

                Text(course.subject)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background(.luckypoint)
                    .clipShape(Capsule())

                Divider()
                    .offset(y: -25)

                VStack {
                    generateFlashcards
                    createQuestion
                    evaluation
                }

            Spacer()
        }
        .padding(.horizontal, 32)
    }
    private var generateFlashcards: some View {
        NavigationLink(
            destination: FlashcardDeckView(flashcardViewModel: flashcardViewModel)) {
                NavigationCardView(title: "Generate Flashcards", icon: "graduationcap")
            }
            .simultaneousGesture(TapGesture().onEnded { _ in
                flashcardViewModel.getFlashcards(course: course)
            })
    }
    
    private var createQuestion: some View {
        NavigationLink(destination: QuestionListView(selectedFiles: course.files, selectedFilesIds: course.filesIds, courseViewModel: courseViewModel, course: course)) {
            NavigationCardView(title: "Ask your Buddy", icon: "questionmark.app")
        }
        .simultaneousGesture(TapGesture().onEnded { _ in
            courseViewModel.getQuestions(courseId: course.course_id!)
        })
    }
    
    private var evaluation: some View {
        NavigationLink(destination: SolveQuizView(courseViewModel: courseViewModel, course: course)) {
            NavigationCardView(title: "Solve your Quiz!", icon: "checkmark.circle")
        }
    }
}

struct NavigationCardView: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color("Purple Primary"))
                .font(Font.title.weight(.light))
            Text(title)
                .font(.headline)
                .foregroundColor(.luckypoint)
        }
        .frame(minWidth: 240)
        .frame(height: 70)
        .padding(32)
        .background(Color("Purple Background"))
        .cornerRadius(16)
        .padding(.bottom, 8)
    }
}


#Preview {
    CourseDetailView(courseViewModel: CourseViewModel(), 
                     course: Course(
                        id: UUID(),
                        title: "Kolumbien Law 101",
                        subject: "International Law",
                        filesIds: [],
                        icon: "book",
                        questions: [],
                        files: []
                     )
    )
}
