import SwiftUI

struct FootballSplashForTeamView: View {
    @StateObject var footballSplashForTeamModel =  FootballSplashForTeamViewModel()
    @Binding var isHidden: Bool
    var body: some View {
        ZStack {
//            Image(.bg)
//                .resizable()
//                .ignoresSafeArea()
            
            Color.black.opacity(0.7).ignoresSafeArea()
            
//            if footballSplashForTeamModel.currentIndex > 0 {
//                Image(.man)
//                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width > 900 ? 1100 : (UIScreen.main.bounds.width > 600 ? 900 : (UIScreen.main.bounds.width > 430 ? 570 : 570)), height: UIScreen.main.bounds.width > 900 ? 1300 : (UIScreen.main.bounds.width > 600 ? 1100 : (UIScreen.main.bounds.width > 430 ? 830 : 820)))
//                    .position(x: UIScreen.main.bounds.width / 1.8, y: UIScreen.main.bounds.height / 2.1)
//            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("\(footballSplashForTeamModel.contact.title[footballSplashForTeamModel.currentIndex])")
                        .AgenorBold(size: 25)
                        .multilineTextAlignment(.center)
                        .frame(height: 70)
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 55/255, green: 218/255, blue: 255/255),
                                                      Color(red: 21/255, green: 150/255, blue: 205/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 5)
                                .overlay {
                                    Text("\(footballSplashForTeamModel.contact.message[footballSplashForTeamModel.currentIndex])")
                                        .AgenorBold(size: 25)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                        }
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.width > 900 ? 600 : (UIScreen.main.bounds.width > 600 ? 480 : (UIScreen.main.bounds.width > 430 ? 332 : 332)), height: UIScreen.main.bounds.width > 900 ? 720 : (UIScreen.main.bounds.width > 600 ? 520 : (UIScreen.main.bounds.width > 430 ? 424 : 424)))
                        .padding(.top, 40)
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .frame(width: 85, height: 85)
                                .overlay {
                                    Button(action: {
                                        withAnimation {
                                            if footballSplashForTeamModel.currentIndex <= 1 {
                                                footballSplashForTeamModel.currentIndex += 1
                                            } else {
                                                isHidden = true
                                            }
                                        }
                                    }) {
                                        Image(.buttonOb)
                                            .resizable()
                                            .frame(width: 85, height: 85)
                                    }
                                    .offset(y: -5)
                                }
                            
                            ForEach(0..<3) { index in
                                Circle()
                                    .trim(from: 0, to: footballSplashForTeamModel.currentIndex >= index ? 0.5 : 0)
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
                        
                        .padding(.top, UIScreen.main.bounds.width > 900 ? 20 : (UIScreen.main.bounds.width > 600 ? 160 : (UIScreen.main.bounds.width > 430 ? 100 : 80)))
                        .padding(.trailing, UIScreen.main.bounds.width > 900 ? 100 : (UIScreen.main.bounds.width > 600 ? 80 : (UIScreen.main.bounds.width > 430 ? 40 : 40)))
                    }
                }
                .padding(.top, 70)
            }
            
//            if footballSplashForTeamModel.currentIndex == 0 {
//                Image(.man)
//                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width > 900 ? 590 : (UIScreen.main.bounds.width > 600 ? 550 : (UIScreen.main.bounds.width > 430 ? 340 : 320)), height: UIScreen.main.bounds.width > 900 ? 700 : (UIScreen.main.bounds.width > 600 ? 700 : (UIScreen.main.bounds.width > 430 ? 490 : 420)))
//                    .position(x: UIScreen.main.bounds.width / 2.4, y: UIScreen.main.bounds.height / 1.53)
//            }
        }
    }
}

#Preview {
    FootballSplashForTeamView(isHidden: .constant(false))
}

