//
//  CourseDetailView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 30.06.23.
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
        VStack(spacing: 10) {
            ScrollView {

                Image("course-detail")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120)

                Text(course.subject)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background(Color("Purple Text"))
                    .clipShape(Capsule())
                

                Divider()
                    .offset(y: -25)

                Spacer()
                VStack{
                    generateFlashcards
                    createQuestion
                    evaluation

                }
                .padding(.horizontal)
                Spacer()
                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(course.title, displayMode: .inline)
    }
}

extension CourseDetailView {
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
        VStack(spacing: 10) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color("Purple Primary"))
                .font(Font.title.weight(.light))
            Text(title)
                .font(.headline)
                .foregroundColor(Color("Purple Text"))
        }
        .frame(minWidth: 240)
        .padding(.vertical, 35)
        .padding(.horizontal, 35)
        .frame(minWidth: 165, minHeight: 170)
        .background(Color("Purple Background"))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        .padding(.bottom, 15)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let course = Course(
            id: UUID(),
            title: "Kolumbien Law 101",
            subject: "International Law",
            filesIds: [],
            icon: "book",
            questions: [],
            files: []
        )
        let courseViewModel = CourseViewModel()
        CourseDetailView(courseViewModel: courseViewModel, course: course)
    }
}
