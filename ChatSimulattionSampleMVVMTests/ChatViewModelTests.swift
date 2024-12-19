//
//  ChatViewModelTests.swift
//  ChatSimulattionSampleMVVM
//
//  Created by user260588 on 10/11/24.
//
import XCTest
@testable import ChatSimulattionSampleMVVM // Replace with your app module name

class ChatViewModelTests: XCTestCase {
    var viewModel: ChatViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ChatViewModel() // Initialize the ViewModel
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testGenerateResponseForOrderQuery() {
        let message = Message(sender: "Customer", content: "I want to check my order status.", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "Can you please provide your order ID?")
    }

    func testGenerateResponseForProblemQuery() {
        let message = Message(sender: "Customer", content: "I have a problem with my order.", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "I'm sorry to hear that. Can you describe the issue?")
    }

    func testGenerateResponseForDamagedProductQuery() {
        let message = Message(sender: "Customer", content: "The product I received is damaged.", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "You can return it for a full refund or exchange. Just let us know!")
    }

    func testGenerateResponseForRefundQuery() {
        let message = Message(sender: "Customer", content: "I want a refund.", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "Refunds typically take 5-7 business days to process.")
    }

    func testGenerateResponseForThankYouQuery() {
        let message = Message(sender: "Customer", content: "Thank you for your help.", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "You're welcome! If you have any other questions, feel free to ask.")
    }

    func testGenerateResponseForUnknownQuery() {
        let message = Message(sender: "Customer", content: "What is your store's policy?", timestamp: Date())
        let response = viewModel.generateResponse(for: message)
        
        XCTAssertEqual(response.sender, "Support")
        XCTAssertEqual(response.content, "Thank you for your message! We will get back to you shortly.")
    }
}

