import SwiftUI

struct FootballStatisticView: View {
    @StateObject var footballStatisticModel =  FootballStatisticViewModel()

    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("STATISTICS")
                        .AgenorBold(size: 25)
                }
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 60) {
                        Rectangle()
                            .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 5)
                                    .overlay {
                                        VStack {
                                            Image(.defaultPhoto)
                                                .resizable()
                                                .frame(width: 83, height: 83)
                                                .overlay {
                                                    Circle()
                                                        .stroke(.white, lineWidth: 4)
                                                }
                                          
                                            
                                            Rectangle()
                                                .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                                                .overlay(content: {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(.white, lineWidth: 3)
                                                        .overlay {
                                                            Text("MVP")
                                                                .AgenorBold(size: 12)
                                                        }
                                                })
                                                .frame(height: 30)
                                                .offset(y: -20)
                                                .padding(.horizontal,  UIScreen.main.bounds.width > 900 ? 400 : (UIScreen.main.bounds.width > 600 ? 320 : (UIScreen.main.bounds.width > 430 ? 130 : 130)))
                                            
                                            Text(footballStatisticModel.randomPlayerName)
                                                .AgenorBold(size: 12)
                                                .offset(y: -15)
                                        }
                                        .offset(y: -20)
                                    }
                                
                                if let note = footballStatisticModel.randomNote {
                                    HStack(spacing: 35) {
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
                                    .offset(y: 65)
                                }
                                
                            })
                            .frame(height: 218)
                            .cornerRadius(24)
                            .padding(.horizontal, 50)
                            .shadow(radius: 5, y: 5)
                        
                        Rectangle()
                            .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 5)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            ZStack {
                                                Circle()
                                                    .stroke(.white, lineWidth: 5)
                                                    .frame(width: 100, height: 100)
                                                    .overlay {
                                                        VStack(spacing: 5) {
                                                            Text("\(footballStatisticModel.totalGoals)")
                                                                .AgenorBold(size: 16)
                                                            
                                                            Text("TOTAL")
                                                                .AgenorBold(size: 16)
                                                        }
                                                    }
                                                
                                                Circle()
                                                    .trim(from: 0, to: 0.38)
                                                    .stroke(
                                                        Color(red: 18/255, green: 138/255, blue: 204/255),
                                                        style: StrokeStyle(
                                                            lineWidth: 5,
                                                            lineCap: .round,
                                                            lineJoin: .round
                                                        )
                                                    )
                                                    .frame(width: 100, height: 100)
                                                    .rotationEffect(.degrees(-90))
                                            }
                                            
                                            VStack {
                                                HStack {
                                                    Rectangle()
                                                        .fill(.blue)
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("GOALS")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.totalGoals)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 70)
                                                
//                                                HStack {
//                                                    Rectangle()
//                                                        .fill(.red)
//                                                        .frame(width: 12, height: 12)
//                                                    
//                                                    Text("wins")
//                                                        .AgenorBold(size: 12)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("541")
//                                                        .AgenorBold(size: 12)
//                                                }
//                                                .padding(.horizontal, 70)
                                                
//                                                HStack {
//                                                    Rectangle()
//                                                        .fill(.blue)
//                                                        .frame(width: 12, height: 12)
//                                                    
//                                                    Text("loses")
//                                                        .AgenorBold(size: 12)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("541")
//                                                        .AgenorBold(size: 12)
//                                                }
//                                                .padding(.horizontal, 70)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(.red)
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("games")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.totalGames)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 70)
                                            }
                                        }
                                    }
                                
                                
                            })
                            .frame(height: 218)
                            .cornerRadius(24)
                            .padding(.horizontal, 50)
                            .shadow(radius: 5, y: 5)
                    }
                    .padding(.top, 70)
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
        .onAppear {
            footballStatisticModel.loadNotes()
        }
    }
}

#Preview {
    FootballStatisticView()
}

