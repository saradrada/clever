//
//  OnboardingViewModel.swift
//  Clever

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }
}
