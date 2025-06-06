import SwiftUI

class FootballTacticViewModel: ObservableObject {
    let contact = FootballTacticModel()
    
    @Published var isMake = false
    @Published var tacticImages: [String] = []
    @Published var loadedImagesData: [String: String] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userId = UserSession.shared.ensureUserId()
    
    func loadTacticImages() {
        isLoading = true
        errorMessage = nil
        
        NetworkManager.shared.loadTacticImages(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let images):
                    self?.tacticImages = images
                    self?.loadImagesData(filenames: images)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.tacticImages = []
                }
            }
        }
    }
    
    func loadImagesData(filenames: [String]) {
        for filename in filenames {
            loadImage(filename: filename)
        }
    }
    
    func loadImage(filename: String) {
        NetworkManager.shared.loadImage(userId: userId, filename: filename) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let base64Data):
                    print("Loaded image \(filename): \(base64Data.prefix(30))...") 
                    self?.loadedImagesData[filename] = base64Data
                case .failure(let error):
                    print("Failed to load image \(filename):", error.localizedDescription)
                }
            }
        }
    }
}
