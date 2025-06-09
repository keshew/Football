import SwiftUI

class FootballTrainingViewModel: ObservableObject {
    let contact = FootballTrainingModel()
    @Published var consecutiveDays: Int = 0
    @Published  var selectedDay: Int? = nil
      private let userDefaults = UserDefaults.standard
      private let lastLaunchKey = "lastLaunchDate"
      private let consecutiveDaysKey = "consecutiveDays"
      private let calendar = Calendar.current
      
      init() {
          updateConsecutiveDays()
          loadCompletedTrainings()
      }
      
      func updateConsecutiveDays() {
          let today = Date()
          let lastLaunchDate = userDefaults.object(forKey: lastLaunchKey) as? Date
          
          if let lastDate = lastLaunchDate {
              if calendar.isDateInYesterday(lastDate) {
                  consecutiveDays = userDefaults.integer(forKey: consecutiveDaysKey) + 1
              } else if calendar.isDateInToday(lastDate) {
                  consecutiveDays = userDefaults.integer(forKey: consecutiveDaysKey)
              } else {
                  consecutiveDays = 1
              }
          } else {
              consecutiveDays = 1
          }
          
          userDefaults.set(today, forKey: lastLaunchKey)
          userDefaults.set(consecutiveDays, forKey: consecutiveDaysKey)
      }
    
    @Published var completedTrainings: Set<CompletedTraining> = []
       
       private let completedKey = "completedTrainingsKey"
       
       func loadCompletedTrainings() {
           guard let data = UserDefaults.standard.data(forKey: completedKey),
                 let saved = try? JSONDecoder().decode(Set<CompletedTraining>.self, from: data) else {
               completedTrainings = []
               return
           }
           completedTrainings = saved
       }
       
       func saveCompletedTrainings() {
           if let data = try? JSONEncoder().encode(completedTrainings) {
               UserDefaults.standard.set(data, forKey: completedKey)
           }
       }
       
    func toggleTrainingCompleted(for day: Int, trainingIndex: Int, displayedDate: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: displayedDate)
        guard let year = components.year, let month = components.month else { return }
        let training = CompletedTraining(day: day, month: month, year: year, trainingIndex: trainingIndex)
        if completedTrainings.contains(training) {
            completedTrainings.remove(training)
        } else {
            completedTrainings.insert(training)
        }
        saveCompletedTrainings()
    }

    func isTrainingCompleted(for day: Int, trainingIndex: Int, displayedDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: displayedDate)
        guard let year = components.year, let month = components.month else { return false }
        let training = CompletedTraining(day: day, month: month, year: year, trainingIndex: trainingIndex)
        return completedTrainings.contains(training)
    }

}
