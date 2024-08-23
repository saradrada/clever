//
//  OnboardingView.swift
//  Clever

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var currentPage = 0

    let cards = OnboardingCards.allCases

    var body: some View {
        VStack {
            SegmentedProgressBarView(currentPage: currentPage, totalPages: cards.count)
                .padding(.top, 50)
                .padding([.leading, .trailing], 20)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .foregroundStyle(LinearGradient(colors: [.blue.opacity(0.1), .yellow.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                    .frame(height: 400)
                GeometryReader { geometry in
                    TabView(selection: $currentPage) {
                        ForEach(cards.indices, id: \.self) { index in
                            OnboardingScreenView(card: cards[index])
                                .tag(index)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .gesture(
                                    DragGesture().onEnded { value in
                                        let dragThreshold: CGFloat = 50
                                        if value.translation.width < -dragThreshold {
                                            if currentPage < cards.count - 1 {
                                                currentPage += 1
                                            } else {
                                                viewModel.completeOnboarding()
                                            }
                                        } else if value.translation.width > dragThreshold {
                                            if currentPage > 0 {
                                                currentPage -= 1
                                            }
                                        }
                                    }
                                )
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut)
                    .transition(.slide)
                }
            }

            bottomNavigation
        }
        .padding(.horizontal, 32)
    }

    private var bottomNavigation: some View {
        HStack {
            Text("Skip")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .onTapGesture {
                    viewModel.completeOnboarding()
                }
            Spacer()
            ZStack {
                Color.blue.opacity(0.5)
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .onTapGesture {
                if currentPage < cards.count - 1 {
                    currentPage += 1
                } else {
                    viewModel.completeOnboarding()
                }
            }
        }
        .padding(.bottom, 30)
    }
}

struct OnboardingScreenView: View {
    let card: OnboardingCards

    var body: some View {
        VStack(spacing: 16) {
            Image(card.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 400)
            Text(card.title)
                .font(.title)
                .fontWeight(.medium)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .center)

            Text("Get an overview of how you are performing and motivate yourself to achieve even more.")
                .multilineTextAlignment(.center)
        }
    }
}


#Preview {
    OnboardingView()
}
