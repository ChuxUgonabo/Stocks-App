//
//  MockStocksViewModel.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-28.
//

import Foundation

class MockStocksViewModel {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchStocks(completion: @escaping (Result<StockList, Error>) -> Void) {
        apiClient.getStocks { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
