//
//  StockListViewModel.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-25.
//

import Foundation

class StockListViewModel {
    
    var stockList = [Stock]()
    let stockAPIClient = StockAPIClient()
    
    func loadStocks(completion: @escaping () -> Void) {
        
        stockAPIClient.getStocks { result in
            
            switch result {
            case .success(let stocks):
                self.stockList = stocks.stocks.map({ stockResponse in
                    Stock(stockResponse: stockResponse)
                })
            case .failure(let error):
                print("Error fetching stocks: \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return stockList.count
    }

    func stockForIndexPath(_ indexPath: IndexPath) -> Stock {
        return stockList[indexPath.row]
    }
    
        
}
