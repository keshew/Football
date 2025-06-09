import SwiftUI

class FootballStatisticViewModel: ObservableObject {
    let contact = FootballStatisticModel()
    @Published var notes: [NetworkManager.Note] = []
    @Published var isAdd = false
    @Published var isHistory = false
    @Published var dribbling: Int = 0
    @Published var accuracyStrikes: Int = 0
    @Published var endurance: Int = 0
    @Published var technique: Int = 0
    @Published var passes: Int = 0
    @Published var totalGames: Int = 0
    @Published var totalGoals: Int = 0
    @Published var randomPlayerName: String = "SASHA OZON"
    @Published var randomNote: NetworkManager.Note? = nil
    
    private let userId = UserSession.shared.ensureUserId()
    private let statsKey = "completedTrainingsKey"
    
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
    
    init() {
        loadCompletedTrainings()
    }
    
    private func calculateStats() {
        totalGames = notes.count
        totalGoals = notes.reduce(0) { $0 + (Int($1.goals) ?? 0) }
        
        if let randomNote = notes.randomElement() {
            self.randomNote = randomNote
        }
    }
    
    func loadCompletedTrainings() {
        guard let data = UserDefaults.standard.data(forKey: statsKey),
              let saved = try? JSONDecoder().decode(Set<CompletedTraining>.self, from: data) else {
            return
        }
        updateTrainingCounts(from: saved)
    }

    
    func updateTrainingCounts(from completedTrainings: Set<CompletedTraining>) {
        // Счётчики для каждого типа тренировки
        var counts = [Int](repeating: 0, count: 5) // 5 тренировок
        
        for training in completedTrainings {
            if training.trainingIndex >= 0 && training.trainingIndex < counts.count {
                counts[training.trainingIndex] += 1
            }
        }
        
        accuracyStrikes = counts[0]
        endurance = counts[1]
        technique = counts[2]
        passes = counts[3]
        dribbling = counts[4]
    }

}

struct StatisticData: Codable {
    var totalGoals: Int
    var totalGames: Int
    var dribbling: Int
    var accuracyStrikes: Int
    var endurance: Int
    var technique: Int
    var passes: Int
}
