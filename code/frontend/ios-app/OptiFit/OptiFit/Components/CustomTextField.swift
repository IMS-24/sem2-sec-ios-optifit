import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var onEditingEnded: (() -> Void)? = nil
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.borderStyle = .none  // No border for a cleaner look.
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = UIColor.label
        textField.delegate = context.coordinator
        
        // Optional: Add a subtle bottom line.
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        textField.layer.addSublayer(bottomLine)
        textField.layer.masksToBounds = true
        // Adjust the bottom line frame in layoutSubviews.
        context.coordinator.bottomLine = bottomLine
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        
        // Update the bottom line frame.
        if let bottomLine = context.coordinator.bottomLine {
            bottomLine.frame = CGRect(x: 0, y: uiView.bounds.height - 1, width: uiView.bounds.width, height: 1)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onEditingEnded: onEditingEnded)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onEditingEnded: (() -> Void)?
        var bottomLine: CALayer?
        
        init(text: Binding<String>, onEditingEnded: (() -> Void)?) {
            _text = text
            self.onEditingEnded = onEditingEnded
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.text = textField.text ?? ""
            onEditingEnded?()
        }
        
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            if let currentText = textField.text,
               let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                self.text = updatedText
            }
            return true
        }
    }
}
