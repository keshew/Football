import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = URL(string: "http://gh552a.twcloack.online/app.php")!
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case serverError(String)
        case decodingError
    }
    
    struct EventsResponse: Decodable {
        let events: [Event]
    }
    
    struct NotesResponse: Decodable {
        let notes: [Note]
    }
    
    func sendRequest<T: Decodable>(with body: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode,
                  let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                if let serverError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
                    completion(.failure(NetworkError.serverError(serverError.error)))
                } else {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }
    
    struct ServerErrorResponse: Decodable {
        let error: String
    }
    
    struct SuccessResponse<T: Decodable>: Decodable {
        let success: String
        let note: T?
        let event: T?
        let imageData: String?
        let filename: String?
    }
    
    func saveNote(userId: String, note: Note, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "saveNote",
            "userId": userId,
            "note": note.dictionary
        ]
        
        sendRequest(with: body) { (result: Result<SuccessResponse<Note>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadNotes(userId: String, completion: @escaping (Result<[Note], Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "loadNote",
            "userId": userId
        ]
        
        sendRequest(with: body) { (result: Result<NotesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    func saveEvent(userId: String, event: Event, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "saveEvent",
            "userId": userId,
            "event": event.dictionary
        ]
        
        sendRequest(with: body) { (result: Result<SuccessResponse<Event>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadEvents(userId: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "loadEvent",
            "userId": userId
        ]
        
        sendRequest(with: body) { (result: Result<EventsResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.events))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveImage(userId: String, base64Image: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "saveImage",
            "userId": userId,
            "imageData": base64Image
        ]
        
        sendRequest(with: body) { (result: Result<SuccessResponse<EmptyResponse>, Error>) in
            switch result {
            case .success(let response):
                if let filename = response.filename {
                    completion(.success(filename))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadImage(userId: String, filename: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "loadImage",
            "userId": userId,
            "filename": filename
        ]
        
        sendRequest(with: body) { (result: Result<ImageDataResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.imageData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    struct Team: Codable {
        let playersName: [String]
        let playersPosition: [String]
        let icon: [String]
        
        var dictionary: [String: Any] {
            return [
                "playersName": playersName,
                "playersPosition": playersPosition,
                "icon": icon
            ]
        }
    }
    
    struct Event: Codable {
        let teamEnemy: Team
        let teamMine: Team
        let date: String
        let time: String
        let nameEvent: String
        
        var dictionary: [String: Any] {
            return [
                "teamEnemy": teamEnemy.dictionary,
                "teamMine": teamMine.dictionary,
                "date": date,
                "time": time,
                "nameEvent": nameEvent
            ]
        }
    }
    
    struct EmptyResponse: Codable {}
}
extension NetworkManager {
    struct Note: Identifiable, Codable {
        let goals: String
        let fouls: String
        let replace: String
        
        var id: UUID {
            UUID()
        }
    }
}

extension NetworkManager.Note {
    var dictionary: [String: Any] {
        return [
            "goals": goals,
            "fouls": fouls,
            "replace": replace
        ]
    }
}

struct ImageDataResponse: Decodable {
    let imageData: String
}

extension NetworkManager {
    struct ImagesResponse: Decodable {
        let images: [String]
    }
    
    func loadTacticImages(userId: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "loadImages",
            "userId": userId
        ]
        
        sendRequest(with: body) { (result: Result<ImagesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.images))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
