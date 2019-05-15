//
//  ProductTableViewCell.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate {
    func deleteCell(id: String)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var qtdLabel: UILabel!
    @IBOutlet weak var qtdStackView: UIStackView!
    @IBOutlet weak var buttonOutlet: RoundButton!
    
    var delegate: ProductTableViewCellDelegate?
    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(product: Product) {
        self.productNameLabel.text = product.name
        self.id = product.id ?? ""
    }

    @IBAction func buttonTap(_ sender: Any) {
        delegate?.deleteCell(id: self.id)
        self.buttonOutlet.backgroundColor = .black
    }
    
}
