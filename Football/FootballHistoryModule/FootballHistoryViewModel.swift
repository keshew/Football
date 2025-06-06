import SwiftUI

class FootballHistoryViewModel: ObservableObject {
    let contact = FootballHistoryModel()
    @Published var isNote = false
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
