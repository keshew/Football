import SwiftUI

struct FootballIntroduceTeamsView: View {
    @StateObject var footballIntroduceTeamsModel =  FootballIntroduceTeamsViewModel()
    let teamEnemy: Team
    let teamMine: Team
    let nameEvent: String
    
    @State var isNext = false
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("MATCH INFORMATION")
                    .AgenorBold(size: 25)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("FIRST TEAM")
                                    .AgenorBold(size: 25)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                ForEach(0..<teamMine.playersName.count, id: \.self) { index in
                                    HStack {
                                        Image(teamMine.icon[index])
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        
                                        Text(teamMine.playersName[index])
                                            .AgenorBold(size: 15)
                                            .lineLimit(1)
                                        
                                        Text(teamMine.playersPosition[index])
                                            .AgenorBold(size: 15)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.6)
                                        Spacer()
                                        
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("SECOND TEAM")
                                    .AgenorBold(size: 25)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                ForEach(0..<teamEnemy.playersName.count, id: \.self) { index in
                                    HStack {
                                        Image(teamEnemy.icon[index])
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        
                                        Text(teamEnemy.playersName[index])
                                            .AgenorBold(size: 15)
                                            .lineLimit(1)
                                        
                                        Text(teamEnemy.playersPosition[index])
                                            .AgenorBold(size: 15)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.6)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 25)
                        
                        Button(action: {
                            isNext = true
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
                                .frame(height: 53)
                                .padding(.horizontal, 120)
                                .shadow(radius: 5, y: 5)
                                .padding(.top, 40)
                        }
                    }
                }
            }
            .padding(.top)
        }
        .fullScreenCover(isPresented: $isNext) {
            FootballTimerView(nameEvent: nameEvent)
        }
    }
}

#Preview {
    FootballIntroduceTeamsView(teamEnemy: Team(playersName: [""], playersPosition: [""], icon: [""]), teamMine: Team(playersName: [""], playersPosition: [""], icon: [""]), nameEvent: "")
}
