//
//  StockTableViewCell.swift
//  CashAppStocks
//
//  Created by Chux Ugonabo MacBook on 2023-05-25.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockTickerLabelView: UILabel!
    @IBOutlet weak var stockNameLabelView: UILabel!
    @IBOutlet weak var stockQuantityLabelView: UILabel!
    @IBOutlet weak var stockCurrentPriceLabelView: UILabel!
    @IBOutlet weak var stockTotalAmountLabelView: UILabel!
    
    static let cellIdentifer = "StockTableViewCell"

    static func nib() ->  UINib {
        return UINib(nibName: cellIdentifer, bundle: nil)
    }
    
    func configure(stock: Stock) {
        stockTickerLabelView.text = stock.ticker
        stockNameLabelView.text = stock.name
        stockQuantityLabelView.text = "\(Int(stock.quantity ?? 0))"
        
        let currentPrice = Double(stock.currentPriceCents) / 100
        let formattedCurrentPrice = String(format: "\(stock.currency) %.2f", currentPrice)
        stockCurrentPriceLabelView.text = "@ \(formattedCurrentPrice)"

        let totalAmount = Double(stock.quantity ?? 0) * currentPrice
        let formattedTotalAmount = String(format: "\(stock.currency) %.2f", totalAmount)
        stockTotalAmountLabelView.text = "\(formattedTotalAmount)"
    }
}
