//
//  MockStockAPIClient.swift
//  CashAppStocksTests
//
//  Created by Chux Ugonabo MacBook on 2023-05-24.
//

import Foundation
import CashAppStocks

protocol APIClient {
    func getStocks(completion: @escaping (Result<Data, Error>) -> Void)
}

class MockStockAPIClient: APIClient {
    
    enum TestScenario: Equatable {
        case valid
        case error
        case empty
    }
    
    private let testScenario: TestScenario
    
    init(testScenario : TestScenario) {
        self.testScenario = testScenario
    }
    
    func getStocks(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let error = NSError(domain: "MockStockAPIClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create mock Stock response"])
        var mockResponse = ""
        
        switch testScenario {
        
        case TestScenario.valid:
            // Valid response
            mockResponse = """
               [
                   {
                       "ticker": "^GSPC", "name": "S&P 500", "currency": "USD", "current_price_cents": 318157, "quantity": null, "current_price_timestamp": 1681845832
                   },
                   {
                       "ticker": "RUNINC", "name": "Runners Inc.", "currency": "USD", "current_price_cents": 3614, "quantity": 5, "current_price_timestamp": 1681845832
                   }
               ]
           """
        
        case TestScenario.empty:
            // Empty response
            mockResponse = """
               []
           """
            
        case TestScenario.error:
            // Invalid response
            completion(.failure(error))
        }
        
        
        if let data = mockResponse.data(using: .utf8) {
            completion(.success(data))
        } else {
            completion(.failure(error))
        }
        
    }
}
