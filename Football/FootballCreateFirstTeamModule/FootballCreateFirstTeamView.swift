import SwiftUI
import UIKit

struct Event: Codable {
    var teamEnemy: Team
    var teamMine: Team
    var date: String
    var time: String
    var nameEvent: String
}

struct Team: Codable {
    var playersName: [String]
    var playersPosition: [String]
    var icon: [String] 
}

struct Player {
    var name: String
    var icon: String
}

struct FootballCreateFirstTeamView: View {
    @StateObject var footballCreateFirstTeamModel =  FootballCreateFirstTeamViewModel()
    let gridIems = [GridItem(.flexible(), spacing: -40),
                    GridItem(.flexible(), spacing: -40)]
    @State var name = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var eventDate: Date = Date()
    @State private var eventTime: Date = Date()
    @State private var eventName: String = ""
    @State var selectedGlobalIconIndex: Int? = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedImages: [UIImage?] = Array(repeating: nil, count: 6)
    @State private var isImagePickerPresented: [Bool] = Array(repeating: false, count: 6)
    @State private var currentPickerIndex: Int? = nil

    func validateCurrentPlayer() -> Bool {
        let team = footballCreateFirstTeamModel.isSecond ? footballCreateFirstTeamModel.secondTeam : footballCreateFirstTeamModel.firstTeam
        let index = footballCreateFirstTeamModel.currentIndex
        
        guard index < team.playersPosition.count, index < team.icon.count else {
            alertMessage = "Invalid player index."
            return false
        }
        
        let position = team.playersPosition[index].trimmingCharacters(in: .whitespacesAndNewlines)
        if position.isEmpty {
            alertMessage = "Player #\(index + 1) position is empty."
            return false
        }
        
        let icon = team.icon[index].trimmingCharacters(in: .whitespacesAndNewlines)
        if icon.isEmpty {
            alertMessage = "Player #\(index + 1) icon is not selected."
            return false
        }
        
        return true
    }

    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text(footballCreateFirstTeamModel.isSecond ? "CREATE SECOND TEAM" : "CREATE FIRST TEAM")
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
                        ForEach(0..<min(footballCreateFirstTeamModel.currentIndex + 2, 6), id: \.self) { index in
                            if footballCreateFirstTeamModel.currentIndex == index {
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
                                                                CustomTextFiled2(text: Binding(
                                                                    get: {
                                                                        footballCreateFirstTeamModel.isSecond ?
                                                                        footballCreateFirstTeamModel.secondTeam.playersName[index] :
                                                                        footballCreateFirstTeamModel.firstTeam.playersName[index]
                                                                    },
                                                                    set: { newValue in
                                                                        if footballCreateFirstTeamModel.isSecond {
                                                                            footballCreateFirstTeamModel.secondTeam.playersName[index] = newValue
                                                                        } else {
                                                                            footballCreateFirstTeamModel.firstTeam.playersName[index] = newValue
                                                                        }
                                                                    }
                                                                ), placeholder: "PLAYER#\(index + 1) name")
                                                            }
                                                    })
                                                    .frame(height: 65)
                                                    .cornerRadius(24)
                                                    .shadow(radius: 5, y: 5)
                                                    .offset(y: -111)
                                                
                                            }
                                        
                                        VStack(spacing: 10) {
                                            CustomTextFiled(text: Binding(
                                                get: {
                                                    footballCreateFirstTeamModel.isSecond ?
                                                    footballCreateFirstTeamModel.secondTeam.playersPosition[index] :
                                                    footballCreateFirstTeamModel.firstTeam.playersPosition[index]
                                                },
                                                set: { newValue in
                                                    if footballCreateFirstTeamModel.isSecond {
                                                        footballCreateFirstTeamModel.secondTeam.playersPosition[index] = newValue
                                                    } else {
                                                        footballCreateFirstTeamModel.firstTeam.playersPosition[index] = newValue
                                                    }
                                                }
                                            ), placeholder: "WRITE HERE POSITION")
                                            
                                            Text("CHOOSE PHOTO")
                                                .AgenorBold(size: 10)
                                            
                                            ZStack {
                                                   if let image = selectedImages[index] {
                                                       Image(uiImage: image)
                                                           .resizable()
                                                           .frame(width: 43, height: 43)
                                                           .clipShape(Circle())
                                                           .overlay(
                                                               Circle()
                                                                   .stroke(Color.white, lineWidth: 2)
                                                           )
                                                   } else {
                                                       Image(.defaultPhoto)
                                                           .resizable()
                                                           .frame(width: 43, height: 43)
                                                           .clipShape(Circle())
                                                           .overlay(
                                                               Circle()
                                                                   .stroke(Color.white, lineWidth: 2)
                                                           )
                                                   }
                                                   
                                                   Button(action: {
                                                       currentPickerIndex = index
                                                       isImagePickerPresented[index] = true
                                                   }) {
                                                       Image(.choosePhoto)
                                                           .resizable()
                                                           .frame(width: 17, height: 17)
                                                   }
                                                   .offset(y: 20)
                                               }
                                               .sheet(isPresented: Binding(
                                                   get: { isImagePickerPresented[index] },
                                                   set: { isImagePickerPresented[index] = $0 }
                                               )) {
                                                   if let currentIndex = currentPickerIndex, currentIndex == index {
                                                       ImagePicker(
                                                           image: Binding(
                                                               get: { selectedImages[index] },
                                                               set: { selectedImages[index] = $0 }
                                                           ),
                                                           isPresented: Binding(
                                                               get: { isImagePickerPresented[index] },
                                                               set: { isImagePickerPresented[index] = $0 }
                                                           )
                                                       )
                                                   }
                                               }
                                            
                                            Text("CHOOSE ICON")
                                                .AgenorBold(size: 10)
                                                .padding(.top, 5)
                                            
                                            HStack {
                                                ForEach(0..<4, id: \.self) { iconIndex in
                                                    let iconName = "iconBoy\(iconIndex + 1)"
                                                    
                                                    Button(action: {
                                                        if footballCreateFirstTeamModel.isSecond {
                                                            footballCreateFirstTeamModel.secondTeam.icon[index] = iconName
                                                        } else {
                                                            footballCreateFirstTeamModel.firstTeam.icon[index] = iconName
                                                        }
                                                    }) {
                                                        Image(iconName)
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 15)
                                                                    .stroke(
                                                                        (footballCreateFirstTeamModel.isSecond ?
                                                                         footballCreateFirstTeamModel.secondTeam.icon[index] :
                                                                         footballCreateFirstTeamModel.firstTeam.icon[index]) == iconName ? Color.blue : Color.clear,
                                                                        lineWidth: 3
                                                                    )
                                                            )
                                                    }
                                                    .buttonStyle(.plain)
                                                }
                                            }


                                        }
                                        .offset(y: 24)
                                    })
                                    .frame(height: 288)
                                    .cornerRadius(24)
                                    .padding(.horizontal, 60)
                                    .shadow(radius: 5, y: 5)
                            } else {
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
                                                                CustomTextFiled2(text: Binding(
                                                                    get: {
                                                                        footballCreateFirstTeamModel.isSecond ?
                                                                        footballCreateFirstTeamModel.secondTeam.playersName[index] :
                                                                        footballCreateFirstTeamModel.firstTeam.playersName[index]
                                                                    },
                                                                    set: { newValue in
                                                                        if footballCreateFirstTeamModel.isSecond {
                                                                            footballCreateFirstTeamModel.secondTeam.playersName[index] = newValue
                                                                        } else {
                                                                            footballCreateFirstTeamModel.firstTeam.playersName[index] = newValue
                                                                        }
                                                                    }
                                                                ), placeholder: "PLAYER#\(index + 1) name")
                                                            }
                                                    })
                                                    .frame(height: 65)
                                                    .cornerRadius(24)
                                                    .shadow(radius: 5, y: 5)
                                                    .offset(y: -111)
                                                
                                            }
                                        
                                        VStack(spacing: 10) {
                                            CustomTextFiled(text: Binding(
                                                get: {
                                                    footballCreateFirstTeamModel.isSecond ?
                                                    footballCreateFirstTeamModel.secondTeam.playersPosition[index] :
                                                    footballCreateFirstTeamModel.firstTeam.playersPosition[index]
                                                },
                                                set: { newValue in
                                                    if footballCreateFirstTeamModel.isSecond {
                                                        footballCreateFirstTeamModel.secondTeam.playersPosition[index] = newValue
                                                    } else {
                                                        footballCreateFirstTeamModel.firstTeam.playersPosition[index] = newValue
                                                    }
                                                }
                                            ), placeholder: "WRITE HERE POSITION")
                                            
                                            Text("CHOOSE PHOTO")
                                                .AgenorBold(size: 10)
                                            
                                            ZStack {
                                                   if let image = selectedImages[index] {
                                                       Image(uiImage: image)
                                                           .resizable()
                                                           .frame(width: 43, height: 43)
                                                           .clipShape(Circle())
                                                           .overlay(
                                                               Circle()
                                                                   .stroke(Color.white, lineWidth: 2)
                                                           )
                                                   } else {
                                                       Image(.defaultPhoto)
                                                           .resizable()
                                                           .frame(width: 43, height: 43)
                                                           .clipShape(Circle())
                                                           .overlay(
                                                               Circle()
                                                                   .stroke(Color.white, lineWidth: 2)
                                                           )
                                                   }
                                                   
                                                   Button(action: {
                                                       currentPickerIndex = index
                                                       isImagePickerPresented[index] = true
                                                   }) {
                                                       Image(.choosePhoto)
                                                           .resizable()
                                                           .frame(width: 17, height: 17)
                                                   }
                                                   .offset(y: 20)
                                               }
                                               .sheet(isPresented: Binding(
                                                   get: { isImagePickerPresented[index] },
                                                   set: { isImagePickerPresented[index] = $0 }
                                               )) {
                                                   if let currentIndex = currentPickerIndex, currentIndex == index {
                                                       ImagePicker(
                                                           image: Binding(
                                                               get: { selectedImages[index] },
                                                               set: { selectedImages[index] = $0 }
                                                           ),
                                                           isPresented: Binding(
                                                               get: { isImagePickerPresented[index] },
                                                               set: { isImagePickerPresented[index] = $0 }
                                                           )
                                                       )
                                                   }
                                               }
                                            
                                            Text("CHOOSE ICON")
                                                .AgenorBold(size: 10)
                                                .padding(.top, 5)
                                            
                                            HStack {
                                                ForEach(0..<4, id: \.self) { iconIndex in
                                                    let iconName = "iconBoy\(iconIndex + 1)"
                                                    
                                                    Button(action: {
                                                        if footballCreateFirstTeamModel.isSecond {
                                                            footballCreateFirstTeamModel.secondTeam.icon[index] = iconName
                                                        } else {
                                                            footballCreateFirstTeamModel.firstTeam.icon[index] = iconName
                                                        }
                                                    }) {
                                                        Image(iconName)
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 15)
                                                                    .stroke(
                                                                        (footballCreateFirstTeamModel.isSecond ?
                                                                         footballCreateFirstTeamModel.secondTeam.icon[index] :
                                                                         footballCreateFirstTeamModel.firstTeam.icon[index]) == iconName ? Color.blue : Color.clear,
                                                                        lineWidth: 3
                                                                    )
                                                            )
                                                    }
                                                    .buttonStyle(.plain)
                                                }
                                            }


                                        }
                                        .offset(y: 24)
                                    })
                                    .frame(height: 288)
                                    .cornerRadius(24)
                                    .padding(.horizontal, 60)
                                    .disabled(true)
                                    .shadow(radius: 5, y: 5)
                                    .opacity(0.5)
                            }
                        }
                    }
                    
                    Button(action: {
                        if validateCurrentPlayer() {
                             if footballCreateFirstTeamModel.isSecond {
                                 if footballCreateFirstTeamModel.currentIndex <= 4 {
                                     footballCreateFirstTeamModel.currentIndex += 1
                                 } else {
                                     footballCreateFirstTeamModel.isDetail = true
                                 }
                             } else {
                                 if footballCreateFirstTeamModel.currentIndex <= 4 {
                                     footballCreateFirstTeamModel.currentIndex += 1
                                 } else {
                                     footballCreateFirstTeamModel.isSecond = true
                                     footballCreateFirstTeamModel.currentIndex = 0
                                 }
                             }
                         } else {
                             showAlert = true
                         }
                    }) {
                        Rectangle()
                            .fill(Color(red: 28/255, green: 113/255, blue: 224/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 4)
                                    .overlay {
                                        Text("NEXT")
                                            .AgenorBold(size: 16)
                                    }
                            }
                            .cornerRadius(24)
                            .frame(height: 43)
                            .padding(.horizontal, 140)
                            .shadow(radius: 5, y: 5)
                    }
                    .padding(.top)
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
        .fullScreenCover(isPresented: $footballCreateFirstTeamModel.isDetail) {
            FootballDetailsView(
                teamEnemy: footballCreateFirstTeamModel.secondTeam,
                teamMine: footballCreateFirstTeamModel.firstTeam,
                date: eventDate,
                time: eventTime,
                nameEvent: eventName
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    FootballCreateFirstTeamView()
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if !isPresented {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}
