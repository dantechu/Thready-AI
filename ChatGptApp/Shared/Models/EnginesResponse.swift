//
//  EnginesResponse.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 5/1/23.
//

import Foundation

struct EnginesResponse: Codable {
    let data: [Engine]
    let object: String
}

struct Engine: Codable, Hashable {
    let id: String
    let object: String
    let owner: String
    let ready: Bool
    let created: Double
    let language: String
    let model: String
    let privateModels: [String]
    let readyModels: [String]
    let usage: EngineUsage?
}

struct EngineUsage: Codable, Hashable {
    let lastUsed: Double
    let runs: Int
    let totalCost: Int
}
