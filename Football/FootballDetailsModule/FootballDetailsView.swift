import SwiftUI

struct FootballDetailsView: View {
    @StateObject var footballDetailsModel =  FootballDetailsViewModel()
    @State private var names: [String] = Array(repeating: "", count: 3)
    @Environment(\.presentationMode) var presentationMode
    
    let teamEnemy: Team
    let teamMine: Team
    let date: Date
    let time: Date
    let nameEvent: String
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("DETAILS")
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
                        ForEach(0..<3, id: \.self) { index in
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
                                                                Text(footballDetailsModel.contact.arrayName[index])
                                                                    .AgenorBold(size: 16)
                                                            }
                                                    })
                                                    .frame(height: 50)
                                                    .cornerRadius(24)
                                                    .shadow(radius: 5, y: 5)
                                                    .offset(y: -54)
                                                
                                            }
                                        
                                        VStack(spacing: 10) {
                                            CustomTextFiled2(text: $names[index], placeholder: footballDetailsModel.contact.arrayPlaceholder[index])
                                                .padding(.horizontal, 40)
                                                .offset(y: 20)
                                        }
                                    })
                                    .frame(height: 158)
                                    .cornerRadius(24)
                                    .padding(.horizontal, 20)
                                    .shadow(radius: 5, y: 5)
                            }
                        }
                    
                    
                    Button(action: {
                        if names.contains(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
                            alertMessage = "Please fill in all fields."
                            showAlert = true
                            return
                        }
                        
                        let datePattern = #"^\d{2}\.\d{2}$"#
                        let dateRegex = try! NSRegularExpression(pattern: datePattern)
                        let dateRange = NSRange(location: 0, length: names[1].utf16.count)
                        if dateRegex.firstMatch(in: names[1], options: [], range: dateRange) == nil {
                            alertMessage = "Date must be in the format DD.MM, for example 10.12"
                            showAlert = true
                            return
                        }
                        
                        let timePattern = #"^\d{2}:\d{2}$"#
                        let timeRegex = try! NSRegularExpression(pattern: timePattern)
                        let timeRange = NSRange(location: 0, length: names[2].utf16.count)
                        if timeRegex.firstMatch(in: names[2], options: [], range: timeRange) == nil {
                            alertMessage = "Time must be in the format HH:mm, for example 14:42"
                            showAlert = true
                            return
                        }
                        
                        let event = Event(
                            teamEnemy: teamEnemy,
                            teamMine: teamMine,
                            date: names[1],
                            time: names[2],
                            nameEvent: names[0]
                        )
                        
                        footballDetailsModel.saveEvent(event: event) { result in
                            switch result {
                            case .success:
                                DispatchQueue.main.async {
                                    self.footballDetailsModel.isTab = true
                                }
                            case .failure(let error):
                                alertMessage = "Ошибка сохранения: \(error.localizedDescription)"
                                showAlert = true
                            }
                        }
                    }) {
                        Rectangle()
                            .fill(Color(red: 28/255, green: 113/255, blue: 224/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 4)
                                    .overlay {
                                        Text("Create")
                                            .AgenorBold(size: 16)
                                    }
                            }
                            .cornerRadius(24)
                            .frame(height: 43)
                            .padding(.horizontal, 140)
                            .shadow(radius: 5, y: 5)
                            .padding(.top, 20)
                    }
                    .padding(.top)
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("ОК")))
        }
        .fullScreenCover(isPresented: $footballDetailsModel.isTab) {
            FootballTabBarView()
        }
    }
}

#Preview {
    FootballDetailsView(teamEnemy: Team(playersName: [""], playersPosition: [""], icon: [""]), teamMine: Team(playersName: [""], playersPosition: [""], icon: [""]), date: Date(), time: Date(), nameEvent: "")
}
