import SwiftUI

class FootballTimerViewModel: ObservableObject {
    let contact = FootballTimerModel()
    @Published var goals = "0"
    @Published var fouls = "0"
    @Published var replace = "0"
    @Published var isHistory = false
    @Published var name = "Match name"
    @Published var isBack = false
    func saveNote(note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        let userId = UserSession.shared.ensureUserId()
        
        let body: [String: Any] = [
            "metod": "saveNote",
            "userId": userId,
            "note": [
                "name": name,
                "goals": note.goals,
                "fouls": note.fouls,
                "replace": note.replace
            ]
        ]
        
        NetworkManager.shared.sendRequest(with: body) { (result: Result<NetworkManager.SuccessResponse<Note>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if !response.success.isEmpty {
                        completion(.success(()))
                    } else {
                        completion(.failure(NetworkManager.NetworkError.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
