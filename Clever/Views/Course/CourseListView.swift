//
//  CourseListView.swift
//  Clever

import SwiftUI

struct CourseListView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    
    let columns = [
        GridItem(.fixed(175)),
        GridItem(.fixed(175))
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                Text("My Courses")
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(alignment: .leading)
                Spacer()
            }
            .padding(.leading, 8)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(courseViewModel.courses.reversed() ) { course in
                    NavigationLink(destination: CourseDetailView(courseViewModel:courseViewModel, course: course)) {
                        CourseCardView(course: course)
                    }
                }
            }
        }
        .navigationBarTitle("Courses")
        .padding(.horizontal, 32)
    }
}

#Preview {
    CourseListView(courseViewModel: CourseViewModel())
}
