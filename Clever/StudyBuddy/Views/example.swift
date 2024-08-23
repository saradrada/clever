//
//  example.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 24.07.23.
//

import SwiftUI

struct example: View {
    @State private var searchText = ""
    
    var body: some View {
//        VStack {
//            Image("read")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100, height: 100)
//                .padding(.top)
//
//
//            Text("Title")
//                .font(.title)
//            Text("Title")
//                .font(.title)
            
            NavigationStack {
                List {
                    // Your list content here
                }
                .searchable(text: $searchText)
                
            }
            .border(.pink)
//        }
    }
}


struct example_Previews: PreviewProvider {
    static var previews: some View {
        example()
    }
}
