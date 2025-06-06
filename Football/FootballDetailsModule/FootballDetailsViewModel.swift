import SwiftUI

class FootballDetailsViewModel: ObservableObject {
    let contact = FootballDetailsModel()
    let userId = UserSession.shared.ensureUserId()
    @Published var isTab = false
    func saveEvent(event: Event, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "saveEvent",
            "userId": userId,
            "event": [
                "teamEnemy": [
                    "playersName": event.teamEnemy.playersName,
                    "playersPosition": event.teamEnemy.playersPosition,
                    "icon": event.teamEnemy.icon
                ],
                "teamMine": [
                    "playersName": event.teamMine.playersName,
                    "playersPosition": event.teamMine.playersPosition,
                    "icon": event.teamMine.icon
                ],
                "date": event.date,
                "time": event.time,
                "nameEvent": event.nameEvent
            ]
        ]
        
        NetworkManager.shared.sendRequest(with: body) { (result: Result<NetworkManager.SuccessResponse<Event>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

class UserSession {
    static let shared = UserSession()
    private let userIdKey = "userId"
    
    private init() {}
    
    var userId: String? {
        get {
            UserDefaults.standard.string(forKey: userIdKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userIdKey)
        }
    }
    
    func ensureUserId() -> String {
        if let id = userId {
            return id
        } else {
            let newId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
            userId = newId
            return newId
        }
    }
}
