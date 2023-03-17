//
//  Home.swift
//  keyboard3
//
//  Created by joshua on 3/17/23.
//

import SwiftUI

struct Home: View {
    @State private var text: String = ""
    @FocusState private var showKeyboard: Bool
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .ignoresSafeArea()
            
            TextField("$0.00", text: $text)
                .inputView{
                    CustiomKeyBoardView()
                    
                }
                .focused($showKeyboard)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .environment(\.colorScheme, .dark)
                .padding([.horizontal, .top],30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
                Rectangle()
                    .fill(Color("BG").gradient)
                    .ignoresSafeArea()
        }
        
    }
    
    //Custom Keyboartd
    @ViewBuilder
    func CustiomKeyBoardView() -> some View{
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10){
            ForEach(1...9, id:\.self){ index in
                keyboardButtonView(.text("\(index)")){
                    //arrow function on tap appends it to text field
                    if text.isEmpty{
                        text.append("$")
                    }
                    text.append("\(index)")
                }
            }
            
            //Other Buttons with zero in center
            keyboardButtonView(.image("delete.backward")){
                if !text.isEmpty{
                    text.removeLast()
                }
                if text == "$"{
                    text.removeLast()
                }
            }
            keyboardButtonView(.text("0")){
                text.append("0")
            }
            keyboardButtonView(.image("checkmark.circle.fill")){
                showKeyboard = false
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background{
            Rectangle()
                .fill(Color.purple.gradient)
                .cornerRadius(25, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            
        }
    }
    
    /// Keyboard Button View
    @ViewBuilder
    func keyboardButtonView(_ value: KeyBoardValue, onTap: @escaping () -> ()) -> some View{
        Button(action: onTap){
            ZStack{
                switch value{
                case .text(let string):
                    Text(string)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                case .image(let image):
                    Image(systemName: image)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .contentShape(Rectangle())
        }
    }
    
}

enum KeyBoardValue{
    case text(String)
    case image(String)
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
