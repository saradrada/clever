//
//  QuestionaryCardView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 08.12.23.
//

import SwiftUI

struct QuestionaryCardView: View {
    @StateObject var textToSpeechViewModel = TextToSpeechViewModel()
    var courseViewModel: CourseViewModel
    
    let question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("**Question:** \(question.question)")
                    .font(.subheadline)
                    .padding(.bottom, 5)
                Spacer()
                Button {
                    textToSpeechViewModel.fetchSpeech(fromText: courseViewModel.formattedQuestionText(question: question))
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundStyle(Color("Purple Primary"))
                }
            }
            Divider()

            Text("Options:")
                .font(.caption)
                .foregroundColor(.gray)

            ForEach(question.options, id: \.self) { option in
                Text("• \(option)")
                    .font(.caption)
            }

            Divider()
            Text("**Answer**: \(question.answer)")
                .font(.subheadline)
                .foregroundColor(Color("Purple Accent"))
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    QuestionaryCardView(courseViewModel: CourseViewModel(), question: Question(question: "What is Mars?", options: ["A planet", "A fruit", "An animal"], answer: "A planet just like our planet Earth"))
}
