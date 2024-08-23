//
//  CardModifier.swift
//  Clever

import SwiftUI

struct CardModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: Constants.cardWidth, height: Constants.cardHeight)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 1)
    }
}

extension View {
    func card() -> some View {
        modifier(CardModifer())
    }
}

struct CardModifer_Previews: PreviewProvider {
    static var previews: some View {
        Text("Example")
            .card()   
    }
}
