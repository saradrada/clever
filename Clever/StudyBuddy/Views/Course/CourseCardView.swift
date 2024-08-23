//
//  CourseCardView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 09.07.23.
//

import SwiftUI

struct CourseCardView: View {
    let course: Course
    
    var body: some View {
        VStack {
            Image(course.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .foregroundColor(.white)
                .padding(.vertical)
            VStack {
                Text(course.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text("\(course.subject)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background(Color("Purple Primary"))
                    .clipShape(Capsule())
            }
            .padding(.bottom)


        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .frame(minWidth: 170, minHeight: 270)
        .background(Color("Purple Background"))
        .cornerRadius(19)
//        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

struct CourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView(
            course: Course(
                id: UUID(),
                title: "Mars: The Red Planet",
                subject: "Science Fiction",
                filesIds: [],
                icon: "1",
                questions: [],
                files: []
            )
        )
    }
}
