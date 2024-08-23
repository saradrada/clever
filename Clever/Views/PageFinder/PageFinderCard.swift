//
//  PageFinderCard.swift
//  Clever

import SwiftUI

struct PageFinderCard: View {
    var text: String
    var pageNumber: String
    
    var body: some View {
        HStack{
            VStack {
                Color.gray
            }
            .frame(maxWidth: 4)
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text("(...) \(text) (...)")
                    .foregroundColor(.black)
                    
                HStack {
                    Spacer()
                    Text("Page: \(pageNumber)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 15)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.gray)
        .cornerRadius(10)
    }
}

struct PageFinderCard_Previews: PreviewProvider {
    static var previews: some View {
        PageFinderCard(text: "Example", pageNumber: "234")
    }
}
