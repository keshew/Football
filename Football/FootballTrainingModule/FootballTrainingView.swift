import SwiftUI

struct FootballTrainingView: View {
    @StateObject var footballTrainingModel = FootballTrainingViewModel()
    
    @State private var displayedDate = Date()

    
    private let calendar = Calendar(identifier: .gregorian)
    private let daysOfWeek = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 0) {
                    Text("TRAINING")
                        .AgenorBold(size: 25)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 16/255, green: 102/255, blue: 144/255),
                                                          Color(red: 27/255, green: 160/255, blue: 255/255)], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .frame(height: 300)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 2)
                                    .overlay {
                                        VStack(spacing: 10) {
                                            HStack {
                                                Button(action: {
                                                    displayedDate = calendar.date(byAdding: .month, value: -1, to: displayedDate) ?? displayedDate
                                                    footballTrainingModel.selectedDay = nil
                                                }) {
                                                    Image(systemName: "chevron.left")
                                                        .font(.system(size: 20, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .padding()
                                                }
                                                
                                                Spacer()
                                                
                                                Text(monthYearString(from: displayedDate))
                                                    .AgenorBold(size: 14)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    displayedDate = calendar.date(byAdding: .month, value: 1, to: displayedDate) ?? displayedDate
                                                    footballTrainingModel.selectedDay = nil
                                                }) {
                                                    Image(systemName: "chevron.right")
                                                        .font(.system(size: 20, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .padding()
                                                    
                                                }
                                            }
                                            .padding(.horizontal)
                                            
                                            VStack(spacing: 5) {
                                                LazyVGrid(columns: columns, spacing: 10) {
                                                    ForEach(daysOfWeek, id: \.self) { day in
                                                        Text(day)
                                                            .Agenor(size: 12)
                                                            .frame(maxWidth: .infinity)
                                                            .multilineTextAlignment(.center)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                                
                                                let days = generateDays()
                                                
                                                LazyVGrid(columns: columns, spacing: 5) {
                                                    ForEach(days, id: \.self) { day in
                                                        Text("\(day.number)")
                                                            .Agenor(size: 12, color: footballTrainingModel.selectedDay == day.number && day.isCurrentMonth ? .black : (day.isCurrentMonth ? .white : Color(red: 138/255, green: 190/255, blue: 223/255)))
                                                            .frame(maxWidth: .infinity, minHeight: 30)
                                                            .multilineTextAlignment(.center)
                                                            .background(
                                                                ZStack {
                                                                    if footballTrainingModel.selectedDay == day.number && day.isCurrentMonth {
                                                                        Circle()
                                                                            .fill(Color.white)
                                                                            .frame(width: 36, height: 36)
                                                                    }
                                                                }
                                                            )
                                                            .clipShape(Circle())
                                                            .contentShape(Circle())
                                                            .onTapGesture {
                                                                if day.isCurrentMonth {
                                                                    footballTrainingModel.selectedDay = day.number
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        .padding(.top, 20)
                                    }
                            }
                            .padding(.horizontal, 40)
                        
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
                                                    .stroke(.white, lineWidth: 3)
                                                    .overlay {
                                                        Text("DAY PROGRESS")
                                                            .AgenorBold(size: 16)
                                                    }
                                            })
                                            .frame(height: 40)
                                            .offset(y: -28)
                                            .padding(.horizontal, 3)
                                        
                                        HStack {
                                            Rectangle()
                                                .fill(.white)
                                                .overlay {
                                                    GeometryReader { geo in
                                                        let totalWidth = geo.size.width
                                                        let spacing: CGFloat = 6
                                                        let maxDaysToShow = 7
                                                        let filledDays = min(footballTrainingModel.consecutiveDays, maxDaysToShow)
                                                        let itemWidth = (totalWidth - spacing * CGFloat(maxDaysToShow - 1)) / CGFloat(maxDaysToShow)
                                                        
                                                        HStack(spacing: spacing) {
                                                            ForEach(0..<filledDays, id: \.self) { _ in
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 1/255, green: 90/255, blue: 175/255),
                                                                                                  Color(red: 28/255, green: 113/255, blue: 224/255)],
                                                                                         startPoint: .leading, endPoint: .trailing))
                                                                    .frame(width: itemWidth, height: 20)
                                                                    .cornerRadius(20)
                                                            }
                                                            ForEach(filledDays..<maxDaysToShow, id: \.self) { _ in
                                                                Rectangle()
                                                                    .fill(Color.clear)
                                                                    .frame(width: itemWidth, height: 20)
                                                                    .cornerRadius(20)
                                                            }
                                                        }
                                                        .padding(.horizontal, 10)
                                                        .padding(.top, 5)
                                                    }
                                                }
                                                .frame(height: 30)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 20)
                                                .offset(y: 20)
                                        }
                                    }
                            })
                            .frame(height: 98)
                            .cornerRadius(24)
                            .padding(.horizontal, 50)
                            .shadow(radius: 5, y: 5)
                            .padding(.top, 20)
                        
                        Rectangle()
                            .fill(Color(red: 0/255, green: 57/255, blue: 164/255))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white, lineWidth: 5)
                                    .overlay {
                                        Text("TRAINING")
                                            .AgenorBold(size: 16)
                                    }
                            })
                            .frame(height: 45)
                            .cornerRadius(24)
                            .padding(.horizontal, 50)
                            .shadow(radius: 5, y: 5)
                            .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5, id: \.self) { index in
                                    VStack(spacing: -20) {
                                        Image("train\(index + 1)")
                                            .resizable()
                                            .frame(width: 120, height: 196)
                                        
                                        Button(action: {
                                            print("tapped")
                                            if let day = footballTrainingModel.selectedDay {
                                                footballTrainingModel.toggleTrainingCompleted(for: day, trainingIndex: index)
                                            }
                                        }) {
                                            Rectangle()
                                                .fill(footballTrainingModel.selectedDay != nil && footballTrainingModel.isTrainingCompleted(for: footballTrainingModel.selectedDay!, trainingIndex: index)
                                                      ? Color.green
                                                      : Color(red: 28/255, green: 113/255, blue: 224/255))
                                                .frame(height: 35)
                                                .cornerRadius(24)
                                                .shadow(radius: 5, y: 5)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(.white, lineWidth: 2)
                                                        .overlay {
                                                            Text(footballTrainingModel.selectedDay != nil && footballTrainingModel.isTrainingCompleted(for: footballTrainingModel.selectedDay!, trainingIndex: index) ? "COMPLETED" : "COMPLETE")
                                                                .AgenorBold(size: 12)
                                                        }
                                                }
                                        }
                                        .disabled(footballTrainingModel.selectedDay == nil) 
                                    }
                                    .padding(.bottom)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        
                    }
                    .padding(.top, 0)
                    
                    Color.clear
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .padding(.top, 20)
        }
    }
    
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
    
    struct Day: Hashable {
        let number: Int
        let isCurrentMonth: Bool
        let isToday: Bool
    }
    
    private func generateDays() -> [Day] {
        var days: [Day] = []
        
        var calendarMonday = calendar
        calendarMonday.firstWeekday = 2
        
        guard let firstOfMonth = calendarMonday.date(from: calendarMonday.dateComponents([.year, .month], from: displayedDate)) else {
            return days
        }
        
        let weekdayOfFirst = calendarMonday.component(.weekday, from: firstOfMonth)
        
        let rangeCurrentMonth = calendar.range(of: .day, in: .month, for: displayedDate)!
        let numberOfDaysInMonth = rangeCurrentMonth.count
        
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedDate)!
        let rangePrevMonth = calendar.range(of: .day, in: .month, for: previousMonth)!
        let numberOfDaysInPrevMonth = rangePrevMonth.count
        
        let daysFromPrevMonthToShow = weekdayOfFirst - 1
        
        for i in 0..<daysFromPrevMonthToShow {
            let dayNumber = numberOfDaysInPrevMonth - daysFromPrevMonthToShow + 1 + i
            days.append(Day(number: dayNumber, isCurrentMonth: false, isToday: false))
        }
        
        let today = Date()
        for day in 1...numberOfDaysInMonth {
            let dateComponents = DateComponents(year: calendar.component(.year, from: displayedDate),
                                                month: calendar.component(.month, from: displayedDate),
                                                day: day)
            let date = calendar.date(from: dateComponents)!
            let isToday = calendar.isDate(date, inSameDayAs: today)
            days.append(Day(number: day, isCurrentMonth: true, isToday: isToday))
        }
        
        while days.count < 35 {
            let dayNumber = days.count - (daysFromPrevMonthToShow + numberOfDaysInMonth) + 1
            days.append(Day(number: dayNumber, isCurrentMonth: false, isToday: false))
        }
        
        return days
    }
}

#Preview {
    FootballTrainingView()
}

struct CompletedTraining: Codable, Hashable {
    let day: Int  
    let trainingIndex: Int 
}
