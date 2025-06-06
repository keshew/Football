import SwiftUI

class FootballOnboardingViewModel: ObservableObject {
    let contact = FootballOnboardingModel()
    @Published var currentIndex = 0
    @Published var isTab = false
}
