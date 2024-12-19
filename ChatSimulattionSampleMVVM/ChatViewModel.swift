//
//  ChatViewModel.swift
//  ChatSimulattionSampleMVVM
//
//  Created by user260588 on 10/11/24.
//
import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(sender: "Support", content: "Hello! How can I assist you today?", timestamp: Date()),
        Message(sender: "Customer", content: "I have a problem with my order.", timestamp: Date()),
        Message(sender: "Support", content: "Can you please provide your order ID?", timestamp: Date())
    ]

    @Published var newMessage: String = ""
    @Published var textEditorHeight: CGFloat = 40 // Initial height for the TextEditor

    func sendMessage() {
        guard !newMessage.isEmpty else { return }

        // Create a new message with a timestamp
        let newMessageObject = Message(sender: "Customer", content: newMessage, timestamp: Date())
        messages.append(newMessageObject)
        newMessage = ""
        textEditorHeight = 40 // Reset height after sending
        
        // Generate a response based on the customer's message
        let responseMessage = generateResponse(for: newMessageObject)
        
        // Simulate a response from support after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.messages.append(responseMessage)
        }
    }

    func generateResponse(for message: Message) -> Message {
        let lowercasedContent = message.content.lowercased()

        switch true {
        case lowercasedContent.contains("order"):
            return Message(sender: "Support", content: "Can you please provide your order ID?", timestamp: Date())
        case lowercasedContent.contains("problem"):
            return Message(sender: "Support", content: "I'm sorry to hear that. Can you describe the issue?", timestamp: Date())
        case lowercasedContent.contains("damaged"):
            return Message(sender: "Support", content: "You can return it for a full refund or exchange. Just let us know!", timestamp: Date())
        case lowercasedContent.contains("refund"):
            return Message(sender: "Support", content: "Refunds typically take 5-7 business days to process.", timestamp: Date())
        case lowercasedContent.contains("thank you"):
            return Message(sender: "Support", content: "You're welcome! If you have any other questions, feel free to ask.", timestamp: Date())
        default:
            return Message(sender: "Support", content: "Thank you for your message! We will get back to you shortly.", timestamp: Date())
        }
    }
}
