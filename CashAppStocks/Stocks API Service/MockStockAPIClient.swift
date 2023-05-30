//
//  MockStockAPIClient.swift
//  CashAppStocksTests
//
//  Created by Chux Ugonabo MacBook on 2023-05-24.
//

import Foundation

class MockStockAPIClient: APIClient {
    
    enum TestScenario: Equatable {
        case valid
        case invalid
        case empty
        case failure
    }
    
    private let testScenario: TestScenario
    
    init(testScenario : TestScenario) {
        self.testScenario = testScenario
    }
    
    func getStocks(completion: @escaping (Result<StockList, Error>) -> Void) {
        
        let error = NSError(domain: "MockStockAPIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create mock Stock response"])
        var stubResponse = ""
        
        switch testScenario {
            
        case .valid:
            // Valid response
            stubResponse = """
               {
               "stocks": [
                   {
                       "ticker": "^GSPC", "name": "S&P 500", "currency": "USD", "current_price_cents": 318157, "quantity": null, "current_price_timestamp": 1681845832
                   },
                   {
                       "ticker": "RUNINC", "name": "Runners Inc.", "currency": "USD", "current_price_cents": 3614, "quantity": 5, "current_price_timestamp": 1681845832
                   }
               ]
           }
           """
            
        case .empty:
            // Empty response
            stubResponse = """
               {
                   "stocks": []
               }
           """
            
        case .invalid:
            // Invalid response
            stubResponse = """
               {
               "stocks": [
                   {
                       "ticker": "^GSPC", "name": "S&P 500", "currency": "USD", "current_price_cents": 318157, "quantity": null, "current_price_timestamp": 1681845832
                   },
                   {
                       "ticker": "RUNINC", "name": "Runners Inc.", "currency": "USD", "current_price_cents": 3614, "quantity": 5, "current_price_timestamp": 1681845832
                   }
               ]
           }malformedmalformedmalformed
           """
        case .failure:
            completion(.failure(error))
            return
        }
        
        
        if let data = stubResponse.data(using: .utf8) {
            
            do {
                let decoder = JSONDecoder()
                let stocks = try decoder.decode(StockList.self, from: data)
                completion(.success(stocks))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(error))
        }
    }
}
