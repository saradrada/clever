//
//  CustomTextField.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 06.07.23.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.6))
            .lineLimit(5)
    }
}

extension View {
    func customTextField() -> some View {
        modifier(TextFieldModifier())
    }
}
