//
//  ArrowButtonModifier.swift
//  Clever

import SwiftUI

struct ArrowButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 45, height: 45)
            .foregroundColor(Color("Purple Primary"))
            .background(Color.white).cornerRadius(25)
    }
}

extension View {
    func arrowButton() -> some View {
        modifier(ArrowButtonModifier())
    }
}
