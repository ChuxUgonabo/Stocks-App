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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() ->  UINib {
        return UINib(nibName: cellIdentifer, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(stock: Stock) {
        stockTickerLabelView.text = stock.ticker
        stockNameLabelView.text = stock.name
        stockQuantityLabelView.text = "\(stock.quantity)"
        stockCurrentPriceLabelView.text = "@ \(stock.currentPriceCents)"
        
        var currentPrice = stock.currentPriceCents / 100
        var totalAmount = (stock.quantity ?? 0) * currentPrice
        
        stockTotalAmountLabelView.text = "\(totalAmount)"
    }
}
