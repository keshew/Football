import SwiftUI

    struct Note: Identifiable, Codable {
        let id: UUID
        let goals: String
        let fouls: String
        let replace: String
    }

struct FootballMakeNoteView: View {
    @StateObject var footballMakeNoteModel =  FootballMakeNoteViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("MAKE NOTE")
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
                        
                        Button(action: {
                            footballMakeNoteModel.isHistory = true
                        }) {
                            Image(.history)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .padding(.trailing)
                    }
                }
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
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
                                                            CustomTextFiled2(text: $footballMakeNoteModel.name, placeholder: "WRITE HERE NAME OF MATCH")
                                                                .padding(.horizontal, 20)
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
                                            
                                            HStack {
                                                CustomTextFiled2(text: $footballMakeNoteModel.goals, placeholder: "22")
                                                    .padding(.horizontal, 90)
                                            }
                                        }
                                        
                                        VStack {
                                            Text("FOULS")
                                                .AgenorBold(size: 18)
                                            
                                            CustomTextFiled2(text: $footballMakeNoteModel.fouls, placeholder: "22")
                                                .padding(.horizontal, 90)
                                        }
                                        
                                        VStack {
                                            Text("REPLACE")
                                                .AgenorBold(size: 18)
                                            
                                            CustomTextFiled2(text: $footballMakeNoteModel.replace, placeholder: "22")
                                                .padding(.horizontal, 90)
                                        }
                                    }
                                    .offset(y: 30)
                                    
                                })
                                .frame(height: 398)
                                .cornerRadius(24)
                                .padding(.horizontal, 50)
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
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
        .fullScreenCover(isPresented: $footballMakeNoteModel.isHistory) {
            FootballHistoryView()
        }
        
        .fullScreenCover(isPresented: $footballMakeNoteModel.isBack) {
            FootballTabBarView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func saveNote() {
        if footballMakeNoteModel.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter the name of the match."
            showAlert = true
            return
        }
        if footballMakeNoteModel.goals.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter goals."
            showAlert = true
            return
        }
        if footballMakeNoteModel.fouls.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter fouls."
            showAlert = true
            return
        }
        if footballMakeNoteModel.replace.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter replace."
            showAlert = true
            return
        }
        
        let newNote = Note(id: UUID(), goals: footballMakeNoteModel.goals, fouls: footballMakeNoteModel.fouls, replace: footballMakeNoteModel.replace)
        
        footballMakeNoteModel.saveNote(note: newNote) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.footballMakeNoteModel.isBack = true
                }
            case .failure(let error):
                alertMessage = "Failed to save note: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

#Preview {
    FootballMakeNoteView()
}

