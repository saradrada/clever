//
//  ProgressBarView.swift
//  Clever

import SwiftUI

struct ProgressBarView: View {
    var progress: CGFloat // Value between 0.0 and 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: 4)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: geometry.size.width * progress, height: 4)
                    .foregroundColor(Color.blue)
            }
            .cornerRadius(2)
        }
        .frame(height: 4) // Height of the progress bar
    }
}

//#Preview {
//    ProgressBarView(progress: 0.1)
//}
struct SegmentedProgressBarView: View {
    var currentPage: Int?
    var totalPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .frame(width: 20, height: 4)
                    .foregroundColor(index == currentPage ? Color.black : Color.gray.opacity(0.4))
            }
        }
        .padding()
    }
}

#Preview {
    SegmentedProgressBarView(currentPage: 0, totalPages: 4)
}
