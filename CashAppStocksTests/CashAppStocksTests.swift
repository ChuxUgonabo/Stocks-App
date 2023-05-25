//
//  CashAppStocksTests.swift
//  CashAppStocksTests
//
//  Created by Chux Ugonabo MacBook on 2023-05-23.
//

import XCTest
@testable import CashAppStocks

final class CashAppStocksTests: XCTestCase {
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
    
    func testParsingValidStockResponse() {
        let sut = makeSUT(testScenario: MockStockAPIClient.TestScenario.valid)
        
        let expectation = XCTestExpectation(description: "Parsing JSON response")
        
        sut.fetchStocks { result in
            switch result {
            case .success(let stocks):
                XCTAssertEqual(stocks.count, 2, "Expected 2 stocks")
                
                let firstStock = stocks[0]
                XCTAssertEqual(firstStock.name, "S&P 500")
                XCTAssertEqual(firstStock.quantity, nil, "nil")
                
                let secondStock = stocks[1]
                XCTAssertEqual(secondStock.name, "Runners Inc.")
                XCTAssertEqual(secondStock.quantity, 5, "5")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Parsing failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testParsingEmptyStockResponse() {
        let sut = makeSUT(testScenario: MockStockAPIClient.TestScenario.empty)

            let expectation = XCTestExpectation(description: "Parsing empty JSON response")
            
            sut.fetchStocks { result in
                switch result {
                case .success(let stocks):
                    XCTAssertEqual(stocks.count, 0, "Expected 0 stocks")
                    
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTFail("Parsing failed with error: \(error)")
                }
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
    


    
    func trackForMemoryLeaks( _ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock{ [weak instance] in
            XCTAssertNil(instance, "INstance should have neen dealocated. Potential memory leak.", file: file, line: line)
        }
    }
    
  
    

    
    
    // MARK: - Helper
    
    func makeSUT(testScenario : MockStockAPIClient.TestScenario) -> StockService {
        return StockService(apiClient: MockStockAPIClient(testScenario: testScenario))
    }

    // Dependency injection
    class StockService {
        
        private let mockStockAPIClient: APIClient
        
        init(apiClient: APIClient) {
            self.mockStockAPIClient = apiClient
        }
        
        func fetchStocks(completion: @escaping (Result<[StockList.Stock], Error>) -> Void) {
            mockStockAPIClient.getStocks { result in
                switch result {
                case .success(let data):
                    do {
                        let stocks = try JSONDecoder().decode([StockList.Stock].self, from: data)
                        completion(.success(stocks))
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }

    
    

}



// API SERVICE FILE





// New File

