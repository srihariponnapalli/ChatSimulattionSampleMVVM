//
//  ContentView.swift
//  ChatSimulattionSampleMVVM
//
//  Created by user260588 on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationView {  // Add NavigationView here
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        ForEach(viewModel.messages) { message in
                            VStack(alignment: message.sender == "Customer" ? .trailing : .leading) {
                                HStack {
                                    if message.sender == "Customer" {
                                        Spacer()
                                        Text(message.content)
                                            .padding()
                                            .background(Color.blue.opacity(0.7))
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .frame(maxWidth: 300, alignment: .trailing)
                                    } else {
                                        Text(message.content)
                                            .padding()
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(10)
                                            .frame(maxWidth: 300, alignment: .leading)
                                        Spacer()
                                    }
                                }
                                Text(message.formattedTimestamp)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                            .id(message.id) // Assign an ID for scrolling
                        }
                    }
                    .padding(.top)
                    .onChange(of: viewModel.messages, { oldValue, newValue in
                        if let lastMessage = viewModel.messages.last {
                            // Scroll to the last message when it changes
                            withAnimation {
                                scrollProxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    })
                }
                
                HStack {
                    DismissableTextEditor(text: $viewModel.newMessage)
                                    .frame(height: viewModel.textEditorHeight) // Set dynamic height for the TextEditor
                                    .padding(8)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(8)
                                    .onChange(of: viewModel.newMessage, { oldValue, newValue in
                                        // Increase height based on text content
                                        let textHeight = newValue.height(withConstrainedWidth: UIScreen.main.bounds.width - 80, font: UIFont.systemFont(ofSize: 16))
                                        viewModel.textEditorHeight = max(40, textHeight + 20) // Minimum height is 40
                                    })
                                Button(action: viewModel.sendMessage) {
                                    Text("Send")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal)
                
                    }
            .padding()
            .navigationTitle("Chat Simulation")
        }
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

