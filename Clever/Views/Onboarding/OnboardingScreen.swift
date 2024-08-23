//
//  OnboardingScreen.swift
//  Clever

import SwiftUI

struct OnboardingScreen2: View {
    let totalPages = 3 // Number of onboarding screens
    
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .foregroundStyle(LinearGradient(colors: [.gray.opacity(0.1), .yellow.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                .frame(height: 400)


            Text("Create your folders")
                .font(.title)
                .fontWeight(.medium)

            Text("Get an overview of how you are performing and motivate yourself to achieve even more.")
                .multilineTextAlignment(.center)

            HStack {
                Text("Skip")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
                ZStack {
                    Color.blue.opacity(0.5)
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onTapGesture {}
            }
        }
        .padding(.horizontal, 32)
    }
}

//#Preview {
//    OnboardingScreen()
//}

