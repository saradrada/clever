//
//  CourseCardView.swift
//  Clever

import SwiftUI

struct CourseCardView: View {
    let course: Course
    
    var body: some View {
        VStack {
            Image(course.icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
            VStack {
                Text(course.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text("\(course.subject)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 4)
                    .background(.coral)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .frame(width: 170, height: 250)
        .background(.gray.opacity(0.1))
        .cornerRadius(19)
    }
}

#Preview {
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
