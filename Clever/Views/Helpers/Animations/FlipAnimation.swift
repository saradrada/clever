//
//  FlipAnimation.swift
//  Clever

import SwiftUI

final class FlipAnimation {
    let animation: AnimationType
    let duration: Double
    let next: FlipAnimation?
    let delay: Double
    var completion: () -> Void
    
    init(_ animation: AnimationType = .easeInOut, duration: Double, next: FlipAnimation? = nil, delay: Double = 0, completion: @escaping () -> Void) {
        self.animation = animation
        self.duration = duration
        self.next = next
        self.delay = delay
        self.completion = completion
    }
    
    enum AnimationType {
        case easeIn,
             easeOut,
             easeInOut,
             spring
    }
    
    func play() {
        switch animation {
        case .easeInOut:
            withAnimation(.easeInOut(duration: duration).delay(delay)) {
                completion()
            }
        case .easeIn:
            withAnimation(.easeIn(duration: duration).delay(delay)) {
                completion()
            }
        case .easeOut:
            withAnimation(.easeOut(duration: duration).delay(delay)) {
                completion()
            }
        case .spring:
            let interpolatedSpeed = 1 / duration
            withAnimation(.interpolatingSpring(stiffness: 30, damping: 8).speed(interpolatedSpeed).delay(delay)) {
                completion()
            }
        }
                
        if let nextAnimation = next {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                nextAnimation.play()
            }
        }
    }

    func playAfter(duration: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.play()
        }
    }
}
