import SwiftUI

class FootballCreateFirstTeamViewModel: ObservableObject {
    let contact = FootballCreateFirstTeamModel()
    @Published var currentIndex = 0
    @Published var isSecond = false
    @Published var isDetail = false
    @Published var firstTeam = Team(playersName: ["PLAYER#1 name", "PLAYER#2 name", "PLAYER#3 name", "PLAYER#4 name", "PLAYER#5 name", "PLAYER#6 name"],
                                   playersPosition: Array(repeating: "", count: 6),
                                   icon: Array(repeating: "", count: 6))

    @Published var secondTeam = Team(playersName: ["PLAYER#1 name", "PLAYER#2 name", "PLAYER#3 name", "PLAYER#4 name", "PLAYER#5 name", "PLAYER#6 name"],
                                    playersPosition: Array(repeating: "", count: 6),
                                    icon: Array(repeating: "", count: 6))

    
    
}
