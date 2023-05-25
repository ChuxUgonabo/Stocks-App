//
//  ViewController.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-23.
//

import UIKit

class StockViewController: UIViewController {
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    var viewModel = StockListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupStocksTableView() {
        stocksTableView.register(StockTableViewCell.nib(), forCellReuseIdentifier: StockTableViewCell.cellIdentifer)
        stocksTableView.dataSource = self
    }
    
}

extension StockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.cellIdentifer, for: indexPath) as? StockTableViewCell else{
            return UITableViewCell()
        }
        
        let stock = viewModel.stockForIndexPath(indexPath)
        cell.configure(stock: stock)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
}

