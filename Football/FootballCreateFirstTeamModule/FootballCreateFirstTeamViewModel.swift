import SwiftUI

class FootballCreateFirstTeamViewModel: ObservableObject {
    let contact = FootballCreateFirstTeamModel()
    @Published var currentIndex = 0
    @Published var isSecond = false
    @Published var isDetail = false
    @Published var firstTeam = Team(playersName: [], playersPosition: [], icon: [])
    @Published var secondTeam = Team(playersName: [], playersPosition: [], icon: [])


    
    
}
