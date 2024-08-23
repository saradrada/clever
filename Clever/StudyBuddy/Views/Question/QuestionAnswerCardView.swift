//
//  QuestionAnswerCardView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 03.07.23.
//

import SwiftUI

struct QuestionAnswerCardView: View {
    @StateObject var textToSpeechViewModel = TextToSpeechViewModel()

    var question: String
    var answer: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .fontWeight(.medium)
            Divider()
            Text(answer)
            HStack {
                Spacer()
                Button {
                    textToSpeechViewModel.fetchSpeech(fromText: answer)
                } label: {
                    Image(systemName: "speaker.wave.2")
                }
            }
        }
        .font(.callout)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4), lineWidth: 0.6))
    }
}

struct QuestionAnswerCardView_Previews: PreviewProvider {
    static var previews: some View {
        let question = "Question"
        let answer = "Answer AnswerAnswer Answer Answer Answer AnswerAnswerAnswer Answer Answer AnswerAnswerAnswer Answer Answer "
        QuestionAnswerCardView(question: question, answer: answer)
    }
}
