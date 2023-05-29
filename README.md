#  README For the Cash App Stocks Application

This is a simple App that displays a Table view with the list of stocks that were retrieved from the specified API. It simply verifies that the API is legitimate before returning the StockList and populating the Table view. I utilised a custom table view cell to display the ticker, name, quantity, price, and total price of each stock.

## Features
- Calls specified API to retrieve stock data
- Checks if the API is accessible / throw error if inaccessible
- Retrieves the response from the API
- Displays the stock data on a table view 

## Installation
- Open the project in Xcode.
- Build and run the project on the simulator or a physical device. (Tested with iPhone 14)
### Usage
    -  Launch the app on your device or simulator.
    - The app will automatically call the API to retrieve stock data.
    - If the API is accessible, the app will display the stock data on a table view.
    
## Code Structure / Architecture 
I followed MVVM pattern, with the following components:
- Model: Represents the data structure of a stock item. - Stocks Model & StocksResponse
- View: Displays the stock data on a table view.
- ViewModel: Handles the logic and communicates with the Model to retrieve the stock data and prepares it for display on the View. The View observes changes in the ViewModel and updates the UI accordingly.

## Testing 

The tests for this resides in one file "CashAppStocksTests". The application includes test cases that span various data retrieval scenarios. Note: I used stub responses to simulate scenarios and avoid calling external services.

- Valid: Test the successful retrieval and parsing of the stock data.
- Empty: Test when the API returns an empty response.
- Invalid: Test when the API returns a corrupted response.
- networkFailure: other errors that may occur
