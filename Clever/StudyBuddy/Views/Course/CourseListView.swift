//
//  CourseListView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 29.06.23.
//

import SwiftUI

struct CourseListView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    
    let columns = [
        GridItem(.fixed(180)),
        GridItem(.fixed(180))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(courseViewModel.courses.reversed() ) { course in
                    NavigationLink(destination: CourseDetailView(courseViewModel:courseViewModel, course: course)) {
                        CourseCardView(course: course)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Courses")
        .padding(.horizontal)
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        let courseViewModel = CourseViewModel()
        CourseListView(courseViewModel: courseViewModel)
        
    }
}
