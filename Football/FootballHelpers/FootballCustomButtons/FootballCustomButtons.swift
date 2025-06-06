import SwiftUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                .frame(height: 42)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 2)
                }
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("Agenor-Bold", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 55)
            
            HStack(spacing: 15) {
                Image(.person)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .AgenorBold(size: 14, color: Color(red: 153/255, green: 173/255, blue: 200/255))
                        .frame(height: 42)
                     
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 30)
        }
    }
}

struct CustomTextFiled2: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 17/255, green: 40/255, blue: 62/255))
                .frame(height: 42)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 2)
                }
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("Agenor-Bold", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            HStack(spacing: 15) {
              Spacer()
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .AgenorBold(size: 14)
                        .frame(height: 42)
                     
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
                Spacer()
            }
        }
    }
}
