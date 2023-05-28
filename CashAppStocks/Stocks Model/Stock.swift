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
    let currentPriceCents: Int
    let quantity: Int?
    let currentPriceTimestamp: Int
    
    init(ticker: String, name: String, currency: String, currentPriceCents: Int, quantity: Int?, currentPriceTimestamp: Int) {
        self.ticker = ticker
        self.name = name
        self.currency = currency
        self.currentPriceCents = currentPriceCents
        self.quantity = quantity
        self.currentPriceTimestamp = currentPriceTimestamp
    }
    
    init(stockResponse: StockList.StockResponse) {
        self.ticker = stockResponse.ticker
        self.name = stockResponse.name
        self.currency = stockResponse.currency
        self.currentPriceCents = stockResponse.current_price_cents
        self.quantity = stockResponse.quantity
        self.currentPriceTimestamp = stockResponse.current_price_timestamp
    }
    
}
