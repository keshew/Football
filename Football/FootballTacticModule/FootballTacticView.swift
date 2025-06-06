import SwiftUI

struct FootballTacticView: View {
    @StateObject var footballTacticModel = FootballTacticViewModel()
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("TACTIC")
                    .AgenorBold(size: 25)
                
                if footballTacticModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = footballTacticModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {
                            Group {
                                if footballTacticModel.tacticImages.isEmpty {
                                    Text("CREATE YOUR FIRST\nTACTIC!")
                                        .AgenorBold(size: 24)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 120)
                                } else {
                                    ForEach(Array(footballTacticModel.tacticImages.enumerated()), id: \.element) { index, filename in
                                        if let base64String = footballTacticModel.loadedImagesData[filename],
                                           let uiImage = decodeBase64ToUIImage(base64String) {
                                            VStack {
                                                ZStack {
                                                    Image(uiImage: uiImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 150)
                                                        .cornerRadius(8)
                                                        .shadow(radius: 3)
                                                        .offset(y: 15)
                                                    
                                                    Rectangle()
                                                        .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                        .overlay(content: {
                                                            RoundedRectangle(cornerRadius: 24)
                                                                .stroke(.white, lineWidth: 5)
                                                                .overlay {
                                                                    Text("TACTIC \(index + 1)")
                                                                        .AgenorBold(size: 15)
                                                                }
                                                        })
                                                        .frame(height: 40)
                                                        .cornerRadius(24)
                                                        .shadow(radius: 5, y: 5)
                                                        .offset(y: -70)
                                                        .padding(.horizontal, UIScreen.main.bounds.width > 900 ? 370 : (UIScreen.main.bounds.width > 600 ? 270 : UIScreen.main.bounds.width > 430 ? 60 : 60))
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                
                Color.clear
                    .frame(height: 60)
            }
            .padding(.top, 30)
            
            Button(action: {
                footballTacticModel.isMake = true
            }) {
                Image(.addBtn)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .position(UIScreen.main.bounds.width > 900 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 430 ? CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3) : CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3))))
        }
        .fullScreenCover(isPresented: $footballTacticModel.isMake) {
            FootballMakeTacticView()
        }
        .onAppear {
            footballTacticModel.loadTacticImages()
        }
    }
    
    func decodeBase64ToUIImage(_ base64String: String) -> UIImage? {
        var cleanedString = base64String
        if let range = cleanedString.range(of: "base64,") {
            cleanedString = String(cleanedString[range.upperBound...])
        }
        guard let data = Data(base64Encoded: cleanedString, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: data)
    }
}


#Preview {
    FootballTacticView()
}

