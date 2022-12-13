import SwiftUI
import UIKit
import Combine

struct KeyboardProperty {
    
   var currentHeight: CGFloat = 0
   var animationDuration: Double = 0
    
}

struct AdaptsKeyboard: ViewModifier {

    @State var keyboardProperty: KeyboardProperty = KeyboardProperty()
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, self.keyboardProperty.currentHeight)
            .edgesIgnoringSafeArea(self.keyboardProperty.currentHeight == 0 ? Edge.Set() : .bottom)
            .animation(self.keyboardProperty.currentHeight == 0 ?
                       Animation.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8) :
                       Animation.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8), value: UUID())
            .onAppear(perform: subscribeToKeyboardEvents)
            
    }

    private let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map {
            KeyboardProperty(currentHeight: ($0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height,
                             animationDuration: ($0.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double))
            
        }

    private let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { KeyboardProperty(currentHeight: CGFloat.zero,
        animationDuration: ($0.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)) }

    private func subscribeToKeyboardEvents() {
        _ = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.self.keyboardProperty, on: self)
    }
}
