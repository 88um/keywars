//
//  CustomTFKeyboard.swift
//  keyboard3
//
//  Created by joshua on 3/17/23.
//

import SwiftUI

extension View{
    
    @ViewBuilder
    func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View{
        self
            .background{
                SetTFKeyboard(keyboardContent: content())
            }
    }
}

fileprivate struct SetTFKeyboard<Content : View> : UIViewRepresentable{
    var keyboardContent: Content
    @State private var hostingController: UIHostingController<Content>?
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async{
            if let textFieldContainerView = uiView.superview?.superview{
                if let textField = textFieldContainerView.findtextField{
                    //If nothing is in the text field
                    if textField.inputView == nil{
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
                        textField.inputView = hostingController?.view
                    }else{
                        hostingController?.rootView = keyboardContent
                    }
                    
                }else{
                    print("Failed to Find ")
                }
            }
        }
    }
    
}

struct CustomTFKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//ExtractingTextField From the Subviews

fileprivate extension UIView{
    var allSubViews : [UIView]{
        return subviews.flatMap{
            [$0] + $0.subviews
        }
    }
    
    var findtextField: UITextField?{
        if let textField = allSubViews.first(where: { view in
            view is UITextField
        }) as? UITextField{
            return textField
        }
        return nil
    }
}
