//
//  CircularButton.swift
//  Clever

import SwiftUI

struct CircularButton: View {
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()
                .background(.luckypoint)
                .clipShape(Circle())
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton(imageName: "square.and.arrow.up.fill") {
            print("Button action")
        }
    }
}
