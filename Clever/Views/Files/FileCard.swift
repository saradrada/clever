//
//  FileCard.swift
//  Clever

import SwiftUI

struct FileCard: View {
    let file: File
    var editable: Bool = false
    var buttonAction: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            Image("icon-\(file.type)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .center) {
                    Text(file.name)
                        .fontWeight(.medium)
                        .lineLimit(1)
                    if editable {
                        VStack(alignment: .trailing) {
                            Button(action: buttonAction) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                Text(file.type)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color("Purple Primary"))
                    .clipShape(Capsule())
            }
        }
        .font(.subheadline)
        .padding(10)
        .background(Color("Purple Background").opacity(0.8))
        .cornerRadius(10)
    }
}

#Preview {
    FileCard(file: File(name: "Planet", type: "audio", file_id: "a0"), editable: false, buttonAction: {})
}
