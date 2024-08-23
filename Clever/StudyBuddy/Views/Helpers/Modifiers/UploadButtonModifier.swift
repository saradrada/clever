//
//  UploadButtonModifier.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 02.12.23.
//

import SwiftUI


struct UploadButtonModifier: ViewModifier {
    var backgroundColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 20)
            .font(.subheadline)
            .foregroundColor(textColor)
            .padding(10)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

extension View {
    func uploadButton(backgroundColor: Color = Color("Purple Background"), textColor: Color = Color("Purple Text")) -> some View {
        modifier(UploadButtonModifier(backgroundColor: backgroundColor, textColor: textColor))
    }
}

#Preview {
    Text("Button")
    .uploadButton()
}
