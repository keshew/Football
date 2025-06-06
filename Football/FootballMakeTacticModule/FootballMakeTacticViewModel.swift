import SwiftUI

class FootballMakeTacticViewModel: ObservableObject {
    let contact = FootballMakeTacticModel()
    @Published var movePositions: [CGSize]
    @Published var myPositions: [CGSize]
    @Published var enemyPositions: [CGSize]
    @Published var addedImages: [(imageName: String, position: CGSize)] = []
    
    init() {
          self.movePositions = Array(repeating: .zero, count: 8)
        self.myPositions = Array(repeating: .zero, count: 6)
        self.enemyPositions = Array(repeating: .zero, count: 6)
      }
    
       @Published var myTeamCount = 0
       @Published var enemyTeamCount = 0
       @Published var movesCount = 0
       
       let maxMyTeam = 6
       let maxEnemyTeam = 6
       let maxMoves = 12
       
       let myTeamImages = ["iconBoy1"]
       let enemyTeamImages = ["iconBoy4"]
       let movesImages: [String] = []
       
       func tryAddImage(named imageName: String, category: String) {
           switch category {
           case "myTeam":
               guard myTeamCount < maxMyTeam else { return }
               addedImages.append((imageName: imageName, position: .zero))
               myTeamCount += 1
           case "enemyTeam":
               guard enemyTeamCount < maxEnemyTeam else { return }
               addedImages.append((imageName: imageName, position: .zero))
               enemyTeamCount += 1
           case "moves":
               guard movesCount < maxMoves else { return }
               addedImages.append((imageName: imageName, position: .zero))
               movesCount += 1
           default:
               break
           }
       }
    
    func saveImage(userId: String, base64Image: String, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.saveImage(userId: userId, base64Image: base64Image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let filename):
                    completion(.success(filename))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
