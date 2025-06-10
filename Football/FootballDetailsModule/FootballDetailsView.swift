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
                                            if index == 0 {
                                                CustomTextFiled2(text: $names[index], placeholder: footballDetailsModel.contact.arrayPlaceholder[index])
                                                    .padding(.horizontal, 40)
                                                    .offset(y: 20)
                                            } else if index == 1 {
                                                DateTF(date: $footballDetailsModel.date)
                                                    .padding(.horizontal, 50)
                                                    .offset(y: 20)
                                            } else {
                                                TimeTF(time: $footballDetailsModel.time)
                                                    .padding(.horizontal, 50)
                                                    .offset(y: 20)
                                            }
                                        }
                                    })
                                    .frame(height: 158)
                                    .cornerRadius(24)
                                    .padding(.horizontal, 20)
                                    .shadow(radius: 5, y: 5)
                            }
                        }
                    
                    
                    Button(action: {
                        if names[0] == "" {
                            alertMessage = "Please fill name"
                            showAlert = true
                            return
                        }
                        
                        if footballDetailsModel.date == Date(timeIntervalSince1970: 0) {
                            alertMessage = "Please enter date"
                            showAlert = true
                            return
                        }
                        
                        if footballDetailsModel.time == Date(timeIntervalSince1970: 0) {
                            alertMessage = "Please enter time"
                            showAlert = true
                            return
                        }
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM"

                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "HH:mm"

                        let event = Event(
                            teamEnemy: teamEnemy,
                            teamMine: teamMine,
                            date: dateFormatter.string(from: footballDetailsModel.date),
                            time: timeFormatter.string(from: footballDetailsModel.time), 
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
            FootballIntroduceTeamsView(teamEnemy: teamEnemy, teamMine: teamMine, nameEvent: nameEvent)
        }
    }
}

#Preview {
    FootballDetailsView(teamEnemy: Team(playersName: [""], playersPosition: [""], icon: [""]), teamMine: Team(playersName: [""], playersPosition: [""], icon: [""]), date: Date(), time: Date(), nameEvent: "")
}

struct DateTF: View {
    @Binding var date: Date
    @State private var selectedDate: Date = Date()
    var label: String = "DATE"
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                    .frame(height: 40)
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }
                
                HStack {
                    if date.timeIntervalSince1970 == 0 {
                        Text("Enter \(label)")
                            .AgenorBold(size: 15)
                    } else {
                        Text(formattedDate(date: date))
                            .AgenorBold(size: 15)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 54)
                .onChange(of: date, perform: { newDate in
                    selectedDate = newDate
                })
               
            }
            .labelsHidden()
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

struct TimeTF: View {
    @Binding var time: Date
    @State private var selectedTime: Date = Date()
    var label: String = "TIME"

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                    .frame(height: 40)
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }

                HStack {
                    if time.timeIntervalSince1970 == 0 {
                        Text("Enter \(label)")
                            .AgenorBold(size: 15)
                    } else {
                        Text(formattedTime(time: time))
                            .AgenorBold(size: 15)
                    }
                }
                .padding(.horizontal)

                DatePicker(
                    "Time",
                    selection: $time,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 54)
                .onChange(of: time) { newTime in
                    selectedTime = newTime
                }
            }
            .labelsHidden()
        }
    }

    func formattedTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
}
