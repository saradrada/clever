//
//  QuizView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 09.07.23.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        Image("coming-soon")
            .resizable()
            .frame(width: 120, height: 120)
            .navigationTitle("Quiz Me")
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
