import SwiftUI

class FootballNotepadViewModel: ObservableObject {
    let contact = FootballNotepadModel()
    @Published var isAdd = false
    @Published var isHistory = false
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

struct SuccessResponse<T: Decodable>: Decodable {
    let success: String?
    let note: T?
    let event: T?
    let imageData: String?
    let filename: String?
}

struct NotesResponse: Decodable {
    let notes: [NetworkManager.Note]
}

