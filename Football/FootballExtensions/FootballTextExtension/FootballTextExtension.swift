import SwiftUI

extension Text {
    func Agenor(size: CGFloat,
            color: Color = .white)  -> some View {
        self.font(.custom("Agenor-Regular", size: size))
            .foregroundColor(color)
    }
    
    func AgenorBold(size: CGFloat,
            color: Color = .white)  -> some View {
        self.font(.custom("Agenor-Bold", size: size))
            .foregroundColor(color)
    }
}
