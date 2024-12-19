//
//  Untitled.swift
//  ChatSimulattionSampleMVVM
//
//  Created by user260588 on 10/11/24.
//
import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let sender: String
    let content: String
    let timestamp: Date
    
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}
