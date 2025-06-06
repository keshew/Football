import SwiftUI

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
    
    func validateCurrentPlayer() -> Bool {
        let team = footballCreateFirstTeamModel.isSecond ? footballCreateFirstTeamModel.secondTeam : footballCreateFirstTeamModel.firstTeam
        let index = footballCreateFirstTeamModel.currentIndex
        
        // Безопасно проверяем, что индекс не выходит за пределы массива
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
                                                                Rectangle()
                                                                    .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(.white, lineWidth: 3)
                                                                            .overlay {
                                                                                Text("PLAYER#\(index + 1) name")
                                                                                    .AgenorBold(size: 12)
                                                                            }
                                                                    }
                                                                    .frame(height: 30)
                                                                    .cornerRadius(8)
                                                                    .padding(.horizontal, 50)
                                                            }
                                                    })
                                                    .frame(height: 50)
                                                    .cornerRadius(24)
                                                    .shadow(radius: 5, y: 5)
                                                    .offset(y: -104)
                                                
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
                                            
                                            Image(.defaultPhoto)
                                                .resizable()
                                                .frame(width: 43, height: 43)
                                                .overlay {
                                                    Circle()
                                                        .stroke(.white, lineWidth: 2)
                                                    
                                                    Button(action: {
                                                        
                                                    }) {
                                                        Image(.choosePhoto)
                                                            .resizable()
                                                            .frame(width: 17, height: 17)
                                                    }
                                                    .offset(y: 20)
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
                                    .frame(height: 258)
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
                                                                Rectangle()
                                                                    .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(.white, lineWidth: 3)
                                                                            .overlay {
                                                                                Text("PLAYER#\(index + 1) name")
                                                                                    .AgenorBold(size: 12)
                                                                            }
                                                                    }
                                                                    .frame(height: 30)
                                                                    .cornerRadius(8)
                                                                    .padding(.horizontal, 50)
                                                            }
                                                    })
                                                    .frame(height: 50)
                                                    .cornerRadius(24)
                                                    .shadow(radius: 5, y: 5)
                                                    .offset(y: -104)
                                                
                                            }
                                        
                                        VStack(spacing: 10) {
                                            CustomTextFiled(text: $name, placeholder: "WRITE HERE POSITION")
                                            
                                            Text("CHOOSE PHOTO")
                                                .AgenorBold(size: 10)
                                            
                                            Image(.defaultPhoto)
                                                .resizable()
                                                .frame(width: 43, height: 43)
                                                .overlay {
                                                    Circle()
                                                        .stroke(.white, lineWidth: 2)
                                                    
                                                    Button(action: {
                                                        
                                                    }) {
                                                        Image(.choosePhoto)
                                                            .resizable()
                                                            .frame(width: 17, height: 17)
                                                    }
                                                    .offset(y: 20)
                                                }
                                            
                                            Text("CHOOSE ICON")
                                                .AgenorBold(size: 10)
                                                .padding(.top, 5)
                                            
                                            HStack {
                                                ForEach(0..<4, id: \.self) { index in
                                                    Button(action: {
                                                        
                                                    }) {
                                                        Image(.iconBoy1)
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                    }
                                                }
                                            }
                                        }
                                        .offset(y: 24)
                                    })
                                    .frame(height: 258)
                                    .cornerRadius(24)
                                    .padding(.horizontal, 60)
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
