import SwiftUI

struct FootballStatisticView: View {
    @StateObject var footballStatisticModel =  FootballStatisticViewModel()

    private var sectors: [StatSector] {
        [
            .init(value: Double(footballStatisticModel.totalGoals), color: Color(red: 94/255, green: 0/255, blue: 255/255)),
            .init(value: Double(footballStatisticModel.totalGames), color: Color(red: 47/255, green: 0/255, blue: 255/255)),
            .init(value: Double(footballStatisticModel.dribbling), color: Color(red: 94/255, green: 92/255, blue: 255/255)),
            .init(value: Double(footballStatisticModel.accuracyStrikes), color: Color(red: 222/255, green: 0/255, blue: 0/255)),
            .init(value: Double(footballStatisticModel.endurance), color: Color(red: 222/255, green: 129/255, blue: 0/255)),
            .init(value: Double(footballStatisticModel.technique), color: Color(red: 42/255, green: 129/255, blue: 0/255)),
            .init(value: Double(footballStatisticModel.passes), color: Color(red: 42/255, green: 129/255, blue: 186/255))
        ]
    }
    private var total: Int {
        sectors.map { Int($0.value) }.reduce(0, +)
    }

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
                                            StatisticCircleView(sectors: sectors, total: total)
                                                .padding(.bottom, 10)
                                            
                                            VStack {
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 94/255, green: 0/255, blue: 255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("GOALS")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.totalGoals)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 47/255, green: 0/255, blue: 255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("GAMES")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.totalGames)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 94/255, green: 92/255, blue: 255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("DRIBBLING")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.dribbling)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 222/255, green: 0/255, blue: 0/255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("Accuracy strikes")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.accuracyStrikes)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 222/255, green: 129/255, blue: 0/255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("Endurance")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.endurance)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 42/255, green: 129/255, blue: 0/255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("Technique")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.technique)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                                
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 42/255, green: 129/255, blue: 186/255))
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text("Passes")
                                                        .AgenorBold(size: 12)
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(footballStatisticModel.passes)")
                                                        .AgenorBold(size: 12)
                                                }
                                                .padding(.horizontal, 50)
                                            }
                                        }
                                    }
                                
                                
                            })
                            .frame(height: 308)
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

struct StatSector {
    let value: Double
    let color: Color
}

struct StatisticCircleView: View {
    let sectors: [StatSector]
    let total: Int
    
    var body: some View {
        ZStack {
            // Белый круг
            Circle()
                .stroke(.white, lineWidth: 5)
                .frame(width: 100, height: 100)
            
            // Сектора
            ForEach(0..<sectors.count, id: \.self) { i in
                let start = angle(for: i)
                let end = angle(for: i + 1)
                CircleSector(startAngle: start, endAngle: end)
                    .stroke(sectors[i].color, lineWidth: 5)
                    .frame(width: 100, height: 100)
            }
            
            // Текст по центру
            VStack(spacing: 5) {
                Text("\(total)")
                    .AgenorBold(size: 16)
                Text("TOTAL")
                    .AgenorBold(size: 16)
            }
        }
    }
    
    private var totalValue: Double {
        sectors.map { $0.value }.reduce(0, +)
    }
    
    private func angle(for index: Int) -> Angle {
        let sum = sectors.prefix(index).map { $0.value }.reduce(0, +)
        return .degrees((sum / totalValue) * 360 - 90)
    }
}


struct CircleSector: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.width / 2
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}

