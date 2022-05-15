//
//  ExchangeRateModel.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/14.
//

import Foundation
import RxSwift


import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let success: Bool
    let query: Query
    let info: Info
    let historical: Bool
    let date: String
    let result: Double
}

// MARK: - Info
struct Info: Codable {
    let timestamp: Int
    let quote: Double
}

// MARK: - Query
struct Query: Codable {
    let from, to: String
    let amount: Int
}
