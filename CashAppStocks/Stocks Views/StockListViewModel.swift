//
//  StockListViewModel.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-25.
//

import Foundation

class StockListViewModel {
    
    var stockList = [Stock]()
    
    
    func addMockStockItem() {
        var stockItem1 = Stock(ticker: "TTT", name: "test one 1 INC.", currency: "USD", currentPriceCents: 886783, quantity: 5, currentPriceTimestamp: 665656565656)
        var stockItem2 = Stock(ticker: "2TTT", name: "test two 2 INC.", currency: "USD", currentPriceCents: 886783, quantity: 15, currentPriceTimestamp: 665656565656)
        var stockItem3 = Stock(ticker: "3TTT", name: "test three 3 INC.", currency: "USD", currentPriceCents: 886783, quantity: nil, currentPriceTimestamp: 665656565656)
        
        stockList.append(stockItem1)
        stockList.append(stockItem2)
        stockList.append(stockItem3)
    }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return stockList.count
    }

    func stockForIndexPath(_ indexPath: IndexPath) -> Stock {
        return stockList[indexPath.row]
    }
    
        
}
