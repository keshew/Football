import SwiftUI

class FootballSplashForTeamViewModel: ObservableObject {
    let contact = FootballSplashForTeamModel()
    @Published var currentIndex = 0
}
