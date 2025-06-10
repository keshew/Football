import SwiftUI

struct FootballEventsView: View {
    @StateObject var footballEventsModel =  FootballEventsViewModel()
    let gridIems = [GridItem(.flexible(), spacing: UIScreen.main.bounds.width > 900 ? -100 : (UIScreen.main.bounds.width > 600 ? -50 : UIScreen.main.bounds.width > 430 ? -40 : -40)),
                    GridItem(.flexible(), spacing: UIScreen.main.bounds.width > 900 ? -100 : (UIScreen.main.bounds.width > 600 ? -50 : UIScreen.main.bounds.width > 430 ? -40 : -40))]
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("TEAM SETUP")
                    .AgenorBold(size: 25)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Group {
                            if footballEventsModel.events.isEmpty {
                                Text("CREATE YOUR FIRST\nEVENT!")
                                    .AgenorBold(size: 24)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 50)
                            } else {
                                ForEach(footballEventsModel.events.indices, id: \.self) { index in
                                    let event = footballEventsModel.events[index]
                                    
                                    Rectangle()
                                        .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 24)
                                                .stroke(.white, lineWidth: 5)
                                                .overlay {
                                                    HStack {
                                                        VStack(spacing: 8) {
                                                            LazyVGrid(columns: gridIems) {
                                                                ForEach(0..<event.teamMine.icon.count, id: \.self) { i in
                                                                    Image(event.teamMine.icon[i])
                                                                        .resizable()
                                                                        .frame(width: 28, height: 28)
                                                                }
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Text("FIRST\nTEAM")
                                                                .AgenorBold(size: 8)
                                                                .multilineTextAlignment(.center)
                                                        }
                                                        .padding(.vertical)
                                                        
                                                        VStack {
                                                            Text(event.nameEvent)
                                                                .AgenorBold(size: 12)
                                                            
                                                            Spacer()
                                                            
                                                            let goalsText = index < footballEventsModel.notes.count ? footballEventsModel.notes[index].goals : "0"
                                                            Text(goalsText)
                                                                .AgenorBold(size: 14)

                                                            Text("GOALS")
                                                                .AgenorBold(size: 14)
                                                            
                                                            Spacer()
                                                            
                                                            VStack(spacing: 0) {
                                                                Text(event.time)
                                                                    .AgenorBold(size: 12)
                                                                
                                                                Text(event.date)
                                                                    .AgenorBold(size: 12)
                                                            }
                                                        }
                                                        .padding(.vertical, 15)
                                                        
                                                        VStack(spacing: 8) {
                                                            LazyVGrid(columns: gridIems) {
                                                                ForEach(0..<event.teamEnemy.icon.count, id: \.self) { i in
                                                                    Image(event.teamEnemy.icon[i])
                                                                        .resizable()
                                                                        .frame(width: 28, height: 28)
                                                                }
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Text("SECOND\nTEAM")
                                                                .AgenorBold(size: 8)
                                                                .multilineTextAlignment(.center)
                                                        }
                                                        .padding(.vertical)
                                                    }
                                                }
                                        }
                                        .frame(height: 149)
                                        .cornerRadius(24)
                                        .padding(.horizontal, UIScreen.main.bounds.width > 600 ? 140 : 40)
                                        .shadow(radius: 5, y: 5)
                                }
                            }
                        }
                        
                        Color.clear
                            .frame(height: 60)
                    }
                    .padding(.vertical)
                }

                .padding(.top)
            }
            .padding(.top, 20)
            
            Button(action: {
                footballEventsModel.isCreate = true
            }) {
                Image(.addBtn)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .position(UIScreen.main.bounds.width > 900 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: UIScreen.main.bounds.width / 1.15, y: UIScreen.main.bounds.height / 1.2) : (UIScreen.main.bounds.width > 430 ? CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3) : CGPoint(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 1.3))))
        }
        .onAppear {
            footballEventsModel.loadEvents()
            footballEventsModel.loadNotes()
        }
        .fullScreenCover(isPresented: $footballEventsModel.isCreate) {
            FootballCreateFirstTeamView()
        }
    }
}

#Preview {
    FootballEventsView()
}

