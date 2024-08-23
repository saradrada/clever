//
//  CardButton.swift
//  Clever

import SwiftUI

struct CardButton: View {
    var title: String
    var description: String
    var buttonAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title3)
                Spacer()
                Text("Recommended")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Button {
                buttonAction()
            } label: {
                Text("Select PDF")
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Purple Accent"))
                    .cornerRadius(10)
            }
            .padding()

        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}


struct CardButton_Previews: PreviewProvider {
    static var previews: some View {
        CardButton(title: "PDF", description: "Import PDF (.pdf) files.\nUsed primarily for Clever to build quizes and flascards.") {
            print("Select PDF button action")
        }
    }
}
