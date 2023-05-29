#  README For the Cash App Stocks Take Home Project 
### By John Vianney Ugonabo

This is a simple App that displays a Table view with the list of stocks that were retrieved from the specified API. It simply verifies that the API is legitimate before returning the StockList and populating the Table view. I utilised a custom table view cell to display the ticker, name, quantity, price, and total price of each stock.

## Features
- Calls specified API to retrieve stock data
- Checks if the API is accessible / throw error if inaccessible
- Retrieves the response from the API
- Displays the stock data on a table view 

## Installation
- This an iOS application built with Swift
- Open the project in Xcode.
- Build and run the project on the simulator or a physical device. (Tested with iPhone 14)

### Usage
    - Launch the app on your device or simulator.
    - The app will automatically call the API to retrieve stock data.
    - If the API is accessible, the app will display the stock data on a table view.
    
## Code Structure / Architecture 

I followed MVVM pattern for this project, below are the components:
- Model: Represents the data structure of a stock item. 
    - Stocks Model 
    - StockList (Model of the Stocks API)
    - Note: I decided to differeniate these to models to enable easy reusability and allow additional extensions
- View: Displays the stock data on a table view.
    - StockViewController
    - Stock Table Cell
- ViewModel: Handles the logic and communicates with the Model to retrieve the stocks data and prepares it for display on the View. The View observes changes in the ViewModel and updates the UI accordingly.
- API Service: I decided to seperate the activities involving the retrieving and parsing the Stocks API Response
    - APIClient: Utitlized this protocol to define the contracts/ functions needed
    - StockAPIClient: Handles all interaction with the API (url request, retrieving and parsing)
    - MockStockAPIClient: Handles for the Mocking and scenerios for testing. Decided to use a MockAPIClient to remove the dependency on external systems while in test

## Testing 

The tests for this resides in one file "CashAppStocksTests". The application includes test cases that span various data retrieval scenarios. Note: I used stub responses to simulate scenarios and avoid calling external services.

- Valid: Test the successful retrieval and parsing of the stock data.
- Empty: Test when the API returns an empty response.
- Invalid: Test when the API returns a corrupted response.
- networkFailure: other errors that may occur

### Test Helpers
- MockStockAPIClient: Used to create a Mock StockAPIClient to test the scenerios list above
- MockStocksViewModel: communicates between the Stock Model and the APIClient

## Additional Information
- I maintained a commit log for code updates and a maintenance log to keep track of code updates and a history of modifications. 
