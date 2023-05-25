//
//  Stock.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-25.
//

import Foundation

public struct Stock {
    let ticker : String
    let name: String
    let currency: String
    let current_price_cents: Int
    let quantity: Int?
    let current_price_timestamp: Int
}
