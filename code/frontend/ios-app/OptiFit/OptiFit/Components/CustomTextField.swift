//
//  CustomTextField.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 01.04.25.
//


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
        textField.borderStyle = .roundedRect
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onEditingEnded: onEditingEnded)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onEditingEnded: (() -> Void)?

        init(text: Binding<String>, onEditingEnded: (() -> Void)?) {
            _text = text
            self.onEditingEnded = onEditingEnded
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            // Update the binding when editing ends.
            self.text = textField.text ?? ""
            // Call the update callback.
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
