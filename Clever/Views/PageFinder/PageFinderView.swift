//
//  PageFinderView.swift
//  Clever

import SwiftUI

struct PageFinderView: View {

    @ObservedObject var courseViewModel: CourseViewModel
    @State var query = ""
    
    var course: Course
    
    var body: some View {
        VStack() {
            Text("Discover information effortlessly with semantic search, providing you with the exact page of the content you're looking for.")
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
                .padding(.bottom)
            
            HStack {
                TextField("What page talks about…", text: $query)
                    .font(.subheadline)
                    .customTextField()
                
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        // TODO: FIX INDEX NAME - FILES
                        query = ""
                    }
                    
            }
            .disabled(courseViewModel.isLoadingpageFinderAnswers)
            .padding(.bottom)
            Divider()
                .padding(.bottom)
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(courseViewModel.pageFinderAnswers) { pageFinder in
                        PageFinderCard(text: pageFinder.pageContent, pageNumber: "\(pageFinder.metadata.pageNumber)")
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("Content Search")
    }
}

struct PageFinderView_Previews: PreviewProvider {
    static var previews: some View {
        let courseViewModel = CourseViewModel()
        let course = Course(
            id: UUID(),
            title: "Title",
            subject: "Subject",
            filesIds: [],
            icon: "book",
            questions: [],
            files: []
        )
        PageFinderView(courseViewModel: courseViewModel, course: course)
    }
}
