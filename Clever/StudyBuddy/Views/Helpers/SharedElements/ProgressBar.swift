//
//  ProgressBar.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 24.11.23.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color("Purple Background"))

                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("Purple Primary"))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
    }
}
