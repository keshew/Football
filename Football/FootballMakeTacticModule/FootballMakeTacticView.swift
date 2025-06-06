import SwiftUI

struct FootballMakeTacticView: View {
    @StateObject var footballMakeTacticModel =  FootballMakeTacticViewModel()
    let gridIems = [GridItem(.flexible(), spacing: -160),
                    GridItem(.flexible(), spacing: -160),
                    GridItem(.flexible(), spacing: -160)]
    @State var name = ""
    @State private var dragOffset: CGSize = .zero
    @Environment(\.presentationMode) var presentationMode
    var tacticArea: some View {
        ZStack {
            Image(.pole)
                .resizable()
                .frame(width: 360, height: 220)
            
           
            ForEach(Array(footballMakeTacticModel.addedImages.enumerated()), id: \.offset) { index, item in
                DraggablePlayerImage(imageName: item.imageName, position: $footballMakeTacticModel.addedImages[index].position)
            }
            
        }
        .frame(width: 360, height: 220)
    }

    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("MAKE TACTIC")
                        .AgenorBold(size: 25)
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.backBtn)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Rectangle()
                            .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 5)
                                    .overlay {
                                        Text("NEW TACTIC")
                                            .AgenorBold(size: 15)
                                    }
                            })
                            .frame(height: 70)
                            .cornerRadius(24)
                            .shadow(radius: 5, y: 5)
                            .padding(.horizontal, 50)
                        
                        ZStack {
                            
                            Image(.pole)
                                .resizable()
                                .frame(width: 360, height: 220)
                            
                            ForEach(Array(footballMakeTacticModel.addedImages.enumerated()), id: \.offset) { index, item in
                                DraggablePlayerImage(imageName: item.imageName, position: $footballMakeTacticModel.addedImages[index].position)
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.white, lineWidth: 5)
                                        .overlay {
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                .overlay(content: {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(.white, lineWidth: 5)
                                                        .overlay {
                                                            Text("PLAYERS")
                                                                .AgenorBold(size: 15)
                                                        }
                                                })
                                                .frame(height: 40)
                                                .cornerRadius(24)
                                                .shadow(radius: 5, y: 5)
                                                .offset(y: -60)
                                                .padding(.horizontal, 2)
                                        }
                                    
                                    
                                })
                                .frame(height: 160)
                                .cornerRadius(24)
                                .padding(.horizontal, 60)
                                .shadow(radius: 5, y: 5)
                            
                            HStack(spacing: -70) {
                                VStack(spacing: 10) {
                                    Text("YOUR TEAM")
                                        .AgenorBold(size: 10)
                                    
                                    VStack(spacing: 8) {
                                        LazyVGrid(columns: gridIems) {
                                            ForEach(0..<6, id: \.self) { index in
                                                DraggablePlayerImage(
                                                         imageName: "iconBoy1",
                                                         position: $footballMakeTacticModel.myPositions[index]
                                                     )
                                                .onTapGesture {
                                                    footballMakeTacticModel.tryAddImage(named: "iconBoy1", category: "myTeam")
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                VStack(spacing: 10) {
                                    Text("ENEMY TEAM")
                                        .AgenorBold(size: 10)
                                    
                                    VStack(spacing: 8) {
                                        LazyVGrid(columns: gridIems) {
                                            ForEach(0..<6, id: \.self) { index in
                                                DraggablePlayerImage(
                                                         imageName: "iconBoy1",
                                                         position: $footballMakeTacticModel.enemyPositions[index]
                                                     )
                                                .onTapGesture {
                                                    footballMakeTacticModel.tryAddImage(named: "iconBoy1", category: "enemyTeam")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .offset(y: 24)
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.white, lineWidth: 5)
                                        .overlay {
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                .overlay(content: {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(.white, lineWidth: 5)
                                                        .overlay {
                                                            Text("MOVES")
                                                                .AgenorBold(size: 15)
                                                        }
                                                })
                                                .frame(height: 40)
                                                .cornerRadius(24)
                                                .shadow(radius: 5, y: 5)
                                                .offset(y: -45)
                                                .padding(.horizontal, 2)
                                            
                                        }
                                })
                                .frame(height: 130)
                                .cornerRadius(24)
                                .padding(.horizontal, 60)
                                .shadow(radius: 5, y: 5)
                            
                            HStack(spacing: 12) {
                                ForEach(0..<footballMakeTacticModel.contact.array.count, id: \.self) { index in
                                    DraggableMoveImage(
                                             imageName: footballMakeTacticModel.contact.array[index],
                                             position: $footballMakeTacticModel.movePositions[index]
                                         )
                                    .onTapGesture {
                                        footballMakeTacticModel.tryAddImage(named: footballMakeTacticModel.contact.array[index], category: "moves")
                                    }
                                }
                            }
                            .offset(y: 20)
                        }
                        
                        Button(action: {
                            captureAndSaveTacticImage()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Rectangle()
                                .fill(Color(red: 28/255, green: 113/255, blue: 224/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(.white, lineWidth: 4)
                                        .overlay {
                                            Text("CREATE")
                                                .AgenorBold(size: 16)
                                        }
                                }
                                .cornerRadius(24)
                                .frame(height: 43)
                                .padding(.horizontal, 140)
                                .shadow(radius: 5, y: 5)
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
    
    func captureAndSaveTacticImage() {
        let image = tacticArea.snapshot(size: CGSize(width: 360, height: 220))
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        print(imageData)
        let base64String = imageData.base64EncodedString()
        print(base64String)
        let userId = UserSession.shared.ensureUserId()
        footballMakeTacticModel.saveImage(userId: userId, base64Image: base64String) { result in
            switch result {
            case .success(let filename):
                print("Image saved with filename: \(filename)")
            case .failure(let error):
                print("Failed to save image: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    FootballMakeTacticView()
}

struct DraggableMoveImage: View {
    let imageName: String
    @Binding var position: CGSize
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 25, height: 25)
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        position.width += value.translation.width
                        position.height += value.translation.height
                        dragOffset = .zero
                    }
            )
    }
}

struct DraggablePlayerImage: View {
    let imageName: String
    @Binding var position: CGSize
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 28, height: 28)
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        position.width += value.translation.width
                        position.height += value.translation.height
                        dragOffset = .zero
                    }
            )
    }
}

import UIKit

extension View {
    func snapshot(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
        let view = controller.view!

        view.bounds = CGRect(origin: .zero, size: size)
        view.backgroundColor = .clear

        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale

        let renderer = UIGraphicsImageRenderer(size: size, format: format)

        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}
