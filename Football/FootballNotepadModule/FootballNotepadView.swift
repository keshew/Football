import SwiftUI

struct FootballNotepadView: View {
    @StateObject var footballNotepadModel =  FootballNotepadViewModel()
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("HISTORY")
                        .AgenorBold(size: 25)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            footballNotepadModel.isHistory = true
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
                        Group {
                            if footballNotepadModel.notes.isEmpty {
                                Text("CREATE YOUR FIRST\nNOTE!")
                                    .AgenorBold(size: 24)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 50)
                            } else {
                                ForEach(footballNotepadModel.notes) { note in
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
                                                                        Text("OVERVIEW OF MATCH")
                                                                            .AgenorBold(size: 14)
                                                                    }
                                                            })
                                                            .frame(height: 50)
                                                            .cornerRadius(24)
                                                            .shadow(radius: 5, y: 5)
                                                            .offset(y: -39)
                                                    }
                                                
                                                HStack(spacing: 40) {
                                                    VStack {
                                                        Text("GOALS")
                                                            .AgenorBold(size: 14)
                                                        Text(note.goals)
                                                            .AgenorBold(size: 16)
                                                    }
                                                    
                                                    VStack {
                                                        Text("FOULS")
                                                            .AgenorBold(size: 14)
                                                        Text(note.fouls)
                                                            .AgenorBold(size: 16)
                                                    }
                                                    
                                                    VStack {
                                                        Text("REPLACE")
                                                            .AgenorBold(size: 14)
                                                        Text(note.replace)
                                                            .AgenorBold(size: 16)
                                                    }
                                                }
                                                .offset(y: 25)
                                            })
                                            .frame(height: 128)
                                            .cornerRadius(24)
                                            .padding(.horizontal, 50)
                                            .shadow(radius: 5, y: 5)
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 28/255, green: 113/255, blue: 224/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(.white, lineWidth: 4)
                                                        .overlay {
                                                            Text("FINISH MATCH")
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
                            }
                        }
                    }
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
            
            Button(action: {
                footballNotepadModel.isAdd = true
            }) {
                Image(.addBtn)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .position(UIScreen.main.bounds.width > 900 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 430 ? CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3) : CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3))))
        }
        .fullScreenCover(isPresented: $footballNotepadModel.isAdd) {
            FootballMakeNoteView()
        }
        
        .fullScreenCover(isPresented: $footballNotepadModel.isHistory) {
            FootballHistoryView()
        }
        .onAppear {
            footballNotepadModel.loadNotes()
        }
    }
}

#Preview {
    FootballNotepadView()
}

