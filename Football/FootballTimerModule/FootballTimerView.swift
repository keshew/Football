import SwiftUI

struct FootballTimerView: View {
    @StateObject var footballTimerModel =  FootballTimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    var nameEvent: String
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text(nameEvent)
                    .AgenorBold(size: 25)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        CountdownTimerView()
                        
                        VStack(spacing: -12) {
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
                                                            Text("OVERVIEW OF MATCH NAME")
                                                                .AgenorBold(size: 18)
                                                        }
                                                })
                                                .frame(height: 70)
                                                .cornerRadius(24)
                                                .shadow(radius: 5, y: 5)
                                                .offset(y: -164)
                                            
                                        }
                                    
                                    VStack(spacing: 20) {
                                        VStack {
                                            Text("GOALS")
                                                .AgenorBold(size: 18)
                                            
                                            HStack(spacing: 30) {
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.goals), value > 0 {
                                                        footballTimerModel.goals = String(value - 1)
                                                    }
                                                }) {
                                                    Image(systemName: "minus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                              
                                                
                                                Rectangle()
                                                    .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(.white, lineWidth: 3)
                                                            .overlay {
                                                                Text("\(footballTimerModel.goals)")
                                                                    .AgenorBold(size: 18)
                                                            }
                                                    })
                                                    .frame(height: 30)
                                                   
                                                
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.goals) {
                                                        footballTimerModel.goals = String(value + 1)
                                                    }
                                                }) {
                                                    Image(systemName: "plus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal,  UIScreen.main.bounds.width > 900 ? 400 : (UIScreen.main.bounds.width > 600 ? 280 : (UIScreen.main.bounds.width > 430 ? 60 : 130)))
                                        }
                                        
                                        VStack {
                                            Text("FOULS")
                                                .AgenorBold(size: 18)
                                            
                                            HStack(spacing: 30) {
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.fouls), value > 0 {
                                                        footballTimerModel.fouls = String(value - 1)
                                                    }
                                                }) {
                                                    Image(systemName: "minus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                              
                                                
                                                Rectangle()
                                                    .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(.white, lineWidth: 3)
                                                            .overlay {
                                                                Text("\(footballTimerModel.fouls)")
                                                                    .AgenorBold(size: 18)
                                                            }
                                                    })
                                                    .frame(height: 30)
                                                   
                                                
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.fouls) {
                                                        footballTimerModel.fouls = String(value + 1)
                                                    }
                                                }) {
                                                    Image(systemName: "plus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal,  UIScreen.main.bounds.width > 900 ? 400 : (UIScreen.main.bounds.width > 600 ? 280 : (UIScreen.main.bounds.width > 430 ? 60 : 130)))
                                        }
                                        
                                        VStack {
                                            Text("REPLACE")
                                                .AgenorBold(size: 18)
                                            
                                            HStack(spacing: 30) {
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.replace), value > 0 {
                                                        footballTimerModel.replace = String(value - 1)
                                                    }
                                                }) {
                                                    Image(systemName: "minus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                              
                                                
                                                Rectangle()
                                                    .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(.white, lineWidth: 3)
                                                            .overlay {
                                                                Text("\(footballTimerModel.replace)")
                                                                    .AgenorBold(size: 18)
                                                            }
                                                    })
                                                    .frame(height: 30)
                                                   
                                                
                                                Button(action: {
                                                    if let value = Int(footballTimerModel.replace) {
                                                        footballTimerModel.replace = String(value + 1)
                                                    }
                                                }) {
                                                    Image(systemName: "plus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal,  UIScreen.main.bounds.width > 900 ? 400 : (UIScreen.main.bounds.width > 600 ? 280 : (UIScreen.main.bounds.width > 430 ? 60 : 130)))
                                        }
                                    }
                                    .offset(y: 30)
                                    
                                })
                                .frame(height: 398)
                                .cornerRadius(24)
                                .padding(.horizontal, 40)
                                .shadow(radius: 5, y: 5)
                            
                            Button(action: {
                                saveNote()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 28/255, green: 113/255, blue: 224/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(.white, lineWidth: 4)
                                            .overlay {
                                                Text("CREATE NOTE")
                                                    .AgenorBold(size: 16)
                                            }
                                    }
                                    .cornerRadius(24)
                                    .frame(height: 53)
                                    .padding(.horizontal, 120)
                                    .shadow(radius: 5, y: 5)
                            }
                        }
                    }
                    .padding(.top)
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
        .fullScreenCover(isPresented: $footballTimerModel.isHistory) {
            FootballHistoryView()
        }
        
        .fullScreenCover(isPresented: $footballTimerModel.isBack) {
            FootballTabBarView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func saveNote() {
        if footballTimerModel.goals.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter goals."
            showAlert = true
            return
        }
        if footballTimerModel.fouls.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter fouls."
            showAlert = true
            return
        }
        if footballTimerModel.replace.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter replace."
            showAlert = true
            return
        }
        
        let newNote = Note(id: UUID(), goals: footballTimerModel.goals, fouls: footballTimerModel.fouls, replace: footballTimerModel.replace)
        
        footballTimerModel.saveNote(note: newNote) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.footballTimerModel.isBack = true
                }
            case .failure(let error):
                alertMessage = "Failed to save note: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

#Preview {
    FootballTimerView(nameEvent: "")
}

import SwiftUI
import Combine

struct CountdownTimerView: View {
    @State private var remainingTime: TimeInterval = 90 * 60
    @State private var timerSubscription: Cancellable?
    @State private var isRunning = false

    var body: some View {
        VStack(spacing: 20) {
            Text(formatTime(remainingTime))
                .AgenorBold(size: 36)
            
            HStack(spacing: 40) {
                Button(action: {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(isRunning ? "PAUSE" : "START")
                        .AgenorBold(size: 16)
                }
                
                Button(action: {
                    resetTimer()
                }) {
                    Text("RESET")
                        .AgenorBold(size: 16)
                }
            }
        }
        .padding()
    }

    func startTimer() {
        if !isRunning && remainingTime > 0 {
            timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        pauseTimer()
                    }
                }
            isRunning = true
        }
    }

    func pauseTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
        isRunning = false
    }

    func resetTimer() {
        pauseTimer()
        remainingTime = 90 * 60
    }

    func formatTime(_ interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
