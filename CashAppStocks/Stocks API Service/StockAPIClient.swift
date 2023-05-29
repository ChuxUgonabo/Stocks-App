//
//  StockAPIService.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-25.
//

import Foundation

protocol APIClient {
    func getStocks(completion: @escaping (Result<StockList, Error>) -> Void)
}

class StockAPIClient: APIClient {
    
    func getStocks(completion: @escaping (Result<StockList, Error>) -> Void) {
        
        
        guard let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let stocks = try decoder.decode(StockList.self, from: data)
                completion(.success(stocks))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
