//
//  OnboardingViewModel.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import Foundation


protocol OnboardingViewModelDelegate: AnyObject {
    func didMoveToNextPage()
    func didFinishOnboarding()
}

class OnboardingViewModel {
    weak var delegate: OnboardingViewModelDelegate?
    
    var items: [OnboardingItem] = [
        OnboardingItem(imageName: "onboarding1"),
        OnboardingItem(imageName: "onboarding2"),
        OnboardingItem(imageName: "onboarding3")
    ]
    
    var currentPage = 0
    
    func moveToNextPage() {
        if currentPage < items.count - 1 {
            currentPage += 1
            delegate?.didMoveToNextPage()
        } else {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            delegate?.didFinishOnboarding()
        }
    }
    
    func shouldShowOnboarding() -> Bool {
        return !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }
}
