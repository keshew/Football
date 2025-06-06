import SwiftUI

struct FootballTabBarView: View {
    @StateObject var footballTabBarModel =  FootballTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .EVENTS
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .EVENTS {
                    FootballEventsView()
                } else if selectedTab == .NOTEPAD {
                    FootballNotepadView()
                } else if selectedTab == .TACTICS {
                    FootballTacticView()
                } else if selectedTab == .STATISTICS {
                    FootballStatisticView()
                } else if selectedTab == .TRAINING {
                    FootballTrainingView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FootballTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case EVENTS
        case NOTEPAD
        case TACTICS
        case STATISTICS
        case TRAINING
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .fill(Color(red: 23/255, green: 32/255, blue: 44/255))
                    .frame(height: 100)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 35)
                 
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: -15)
            }
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .EVENTS, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .NOTEPAD, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .TACTICS, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .STATISTICS, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .TRAINING, selectedTab: $selectedTab)
            }
            .padding(.top, 15)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("\(tab)")
                    .Agenor(size: 10, color: selectedTab == tab ? Color(red: 28/255, green: 113/255, blue: 224/255) : .white)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
