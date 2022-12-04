//
//  QuotesTableViewCell.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import UIKit

class QuotesTableViewCell: UITableViewCell {
    //MARK: Variables
    @IBOutlet weak var quotesLabel: UILabel!
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: Methods
    func configure(model: QuotesModel?) {
        quotesLabel.text = model?.quote
    }
}
