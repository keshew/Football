import SwiftUI

struct FootballOnboardingView: View {
    @StateObject var footballOnboardingModel =  FootballOnboardingViewModel()

    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            if footballOnboardingModel.currentIndex > 0 {
                Image(.man)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width > 900 ? 1100 : (UIScreen.main.bounds.width > 600 ? 900 : (UIScreen.main.bounds.width > 430 ? 570 : 570)), height: UIScreen.main.bounds.width > 900 ? 1300 : (UIScreen.main.bounds.width > 600 ? 1100 : (UIScreen.main.bounds.width > 430 ? 830 : 820)))
                    .position(x: UIScreen.main.bounds.width / 1.8, y: UIScreen.main.bounds.height / 2.1)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("\(footballOnboardingModel.contact.title[footballOnboardingModel.currentIndex])")
                        .AgenorBold(size: 25)
                        .multilineTextAlignment(.center)
                        .frame(height: 70)
                    
                    Image(footballOnboardingModel.contact.image[footballOnboardingModel.currentIndex])
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width > 900 ? 600 : (UIScreen.main.bounds.width > 600 ? 480 : (UIScreen.main.bounds.width > 430 ? 332 : 332)), height: UIScreen.main.bounds.width > 900 ? 720 : (UIScreen.main.bounds.width > 600 ? 520 : (UIScreen.main.bounds.width > 430 ? 424 : 424)))
                        .padding(.top, footballOnboardingModel.currentIndex == 0 ? 40 : UIScreen.main.bounds.width > 900 ? 300 : (UIScreen.main.bounds.width > 600 ? 240 : (UIScreen.main.bounds.width > 430 ? 180 : 120)))
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .frame(width: 85, height: 85)
                                .overlay {
                                    Button(action: {
                                        withAnimation {
                                            if footballOnboardingModel.currentIndex <= 2 {
                                                footballOnboardingModel.currentIndex += 1
                                            } else {
                                                footballOnboardingModel.isTab = true
                                            }
                                        }
                                    }) {
                                        Image(.buttonOb)
                                            .resizable()
                                            .frame(width: 85, height: 85)
                                    }
                                    .offset(y: -5)
                                }
                            
                            ForEach(0..<4) { index in
                                Circle()
                                    .trim(from: 0, to: footballOnboardingModel.currentIndex >= index ? 0.25 : 0)
                                    .stroke(
                                        Color(red: 18/255, green: 138/255, blue: 204/255),
                                        style: StrokeStyle(
                                            lineWidth: 3,
                                            lineCap: .round,
                                            lineJoin: .round
                                        )
                                    )
                                    .frame(width: 85, height: 85)
                                    .rotationEffect(.degrees(-90 + Double(index) * 90))
                            }
                        }

                        .padding(.top, footballOnboardingModel.currentIndex == 0 ? UIScreen.main.bounds.width > 900 ? 280 : (UIScreen.main.bounds.width > 600 ? 360 : (UIScreen.main.bounds.width > 430 ? 180 : 110)) : UIScreen.main.bounds.width > 900 ? 20 : (UIScreen.main.bounds.width > 600 ? 160 : (UIScreen.main.bounds.width > 430 ? 40 : 30)))
                        .padding(.trailing, UIScreen.main.bounds.width > 900 ? 100 : (UIScreen.main.bounds.width > 600 ? 80 : (UIScreen.main.bounds.width > 430 ? 40 : 40)))
                    }
                }
                .padding(.top, 30)
            }
            
            if footballOnboardingModel.currentIndex == 0 {
                Image(.man)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width > 900 ? 590 : (UIScreen.main.bounds.width > 600 ? 550 : (UIScreen.main.bounds.width > 430 ? 340 : 320)), height: UIScreen.main.bounds.width > 900 ? 700 : (UIScreen.main.bounds.width > 600 ? 700 : (UIScreen.main.bounds.width > 430 ? 490 : 420)))
                    .position(x: UIScreen.main.bounds.width / 2.4, y: UIScreen.main.bounds.height / 1.53)
            }
        }
        .fullScreenCover(isPresented: $footballOnboardingModel.isTab) {
            FootballTabBarView()
        }
    }
}

#Preview {
    FootballOnboardingView()
}
