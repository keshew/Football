import SwiftUI

class FootballEventsViewModel: ObservableObject {
    let contact = FootballEventsModel()
    @Published var isCreate = false
    @Published var events: [NetworkManager.Event] = []
    
    func loadEvents() {
        let userId = UserSession.shared.ensureUserId()
        
        NetworkManager.shared.loadEvents(userId: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    print("Failed to load events: \(error.localizedDescription)")
                }
            }
        }
    }
}
