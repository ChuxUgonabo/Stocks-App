//
//  CashAppStocksTests.swift
//  CashAppStocksTests
//
//  Created by Chux Ugonabo MacBook on 2023-05-23.
//

import XCTest
@testable import CashAppStocks

final class CashAppStocksTests: XCTestCase {
    
    func testParsingValidStockResponse() {
        let sut = makeSUT(testScenario: MockStockAPIClient.TestScenario.valid)
        
        let expectation = XCTestExpectation(description: "Parsing JSON response")
        
        sut.fetchStocks { result in
            switch result {
            case .success(let stocks):
                XCTAssertEqual(stocks.stocks.count, 2, "Expected 2 stocks")
                
                let firstStock = stocks.stocks[0]
                XCTAssertEqual(firstStock.name, "S&P 500")
                XCTAssertEqual(firstStock.currency, "USD")
                XCTAssertEqual(firstStock.current_price_cents, 318157)
                XCTAssertEqual(firstStock.quantity, nil, "nil")
                XCTAssertEqual(firstStock.current_price_timestamp, 1681845832)
                
                
                let secondStock = stocks.stocks[1]
                XCTAssertEqual(secondStock.name, "Runners Inc.")
                XCTAssertEqual(secondStock.currency, "USD")
                XCTAssertEqual(secondStock.current_price_cents, 3614)
                XCTAssertEqual(secondStock.quantity, 5, "5")
                XCTAssertEqual(secondStock.current_price_timestamp, 1681845832)
                
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
                XCTAssertEqual(stocks.stocks.count, 0, "Expected 0 stocks")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Parsing failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testParsingInValidStockResponse() {
        let sut = makeSUT(testScenario: MockStockAPIClient.TestScenario.invalid)
        let expectation = XCTestExpectation(description: "Parsing JSON response")
        
        sut.fetchStocks { result in
            
            switch result {
            case .success(let stocks):
                XCTFail("Expected an error to be thrown, but received successful result: \(stocks)")
                
            case .failure(let error):
                
                // Assert that the error is of the expected type or contains the expected error message
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        XCTAssertEqual(context.debugDescription, "The given data was not valid JSON.", "Expected debugDescription to match")
                        if let underlyingError = context.underlyingError as NSError?,
                           let underlyingDebugDescription = underlyingError.userInfo[NSDebugDescriptionErrorKey] as? String {
                            XCTAssertEqual(underlyingDebugDescription, "Garbage at end around line 10, column 1.", "Expected underlyingError debugDescription to match")
                        }
                        
                    default:
                        XCTFail("Expected DecodingError.dataCorrupted, but received: \(decodingError)")
                    }
                } else {
                    XCTFail("Expected DecodingError.dataCorrupted, but received: \(error)")
                }
                
                expectation.fulfill()
                
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    //testNetworkFailure or other erors
    func testNetworkFailure() {
        let sut = makeSUT(testScenario: MockStockAPIClient.TestScenario.networkFailure)
        let expectation = XCTestExpectation(description: "Network Failor error")
        
        sut.fetchStocks { result in
            switch result {
            case .success(let stocks):
                XCTFail("Expected an error to be thrown, but received successful result: \(stocks)")
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Failed to create mock Stock response")
                expectation.fulfill()
            }
        }
    }
        // MARK: - Helper
        
        func makeSUT(testScenario : MockStockAPIClient.TestScenario) -> MockStocksViewModel {
            return MockStocksViewModel(apiClient: MockStockAPIClient(testScenario: testScenario))
        }
}
