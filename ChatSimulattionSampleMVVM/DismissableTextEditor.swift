//
//  DismissableTextEditor.swift
//  ChatSimulattionSampleMVVM
//
//  Created by user260588 on 10/11/24.
//
import SwiftUI

struct DismissableTextEditor: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DismissableTextEditor

        init(parent: DismissableTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // Dismiss the keyboard when "Return" is pressed
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 16)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

