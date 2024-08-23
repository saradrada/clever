//
//  WideButton.swift
//  Clever

import SwiftUI

struct WideButton: View {
    var text: String
    var buttonAction: () -> Void
    var backgroundColor: Color = .luckypoint

    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}

struct WideButton_Previews: PreviewProvider {
    static var previews: some View {
        WideButton(text: "Text button") {
            print("Button action")
        }
    }
}
