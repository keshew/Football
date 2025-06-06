import SwiftUI

class FootballStatisticViewModel: ObservableObject {
    let contact = FootballStatisticModel()
    @Published var notes: [NetworkManager.Note] = []
      @Published var isAdd = false
      @Published var isHistory = false
      
      @Published var totalGames: Int = 0
      @Published var totalGoals: Int = 0
      @Published var randomPlayerName: String = "SASHA OZON"
      @Published var randomNote: NetworkManager.Note? = nil
      
      private let userId = UserSession.shared.ensureUserId()
      
      func loadNotes() {
          NetworkManager.shared.loadNotes(userId: userId) { [weak self] result in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let notes):
                      self?.notes = notes
                      self?.calculateStats()
                  case .failure(let error):
                      print("Failed to load notes:", error.localizedDescription)
                  }
              }
          }
      }
      
      private func calculateStats() {
          totalGames = notes.count
          totalGoals = notes.reduce(0) { $0 + (Int($1.goals) ?? 0) }
          
          if let randomNote = notes.randomElement() {
              self.randomNote = randomNote
          }
      }
}
