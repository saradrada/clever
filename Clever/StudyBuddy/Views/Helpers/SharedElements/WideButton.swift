//
//  WideButton.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 30.06.23.
//

import SwiftUI

struct WideButton: View {
    var text: String
    var buttonAction: () -> Void
    var backgroundColor: Color = Color("Purple Text")
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
//                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
//        .padding(.horizontal, 35)
    }
}

struct WideButton_Previews: PreviewProvider {
    static var previews: some View {
        WideButton(text: "Text button") {
            print("Button action")
        }
    }
}
