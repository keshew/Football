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
    
    @Published var notes: [NetworkManager.Note] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadNotes() {
        isLoading = true
        errorMessage = nil
        
        let userId = UserSession.shared.ensureUserId()
        
        NetworkManager.shared.loadNotes(userId: userId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let notes):
                    self.notes = notes
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.notes = []
                }
            }
        }
    }
}
