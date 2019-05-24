//
//  MembersCollectionViewCell.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 20/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class MembersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Foto: ProductView!
    @IBOutlet weak var Celula: UIView!
    @IBOutlet weak var Transparencia: ProductView!
    @IBOutlet weak var Nome: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(member: User, selectedId: String) {
        if selectedId == member.id {
            Transparencia.backgroundColor = .red
        } else {
            Transparencia.backgroundColor = .white
        }
        self.Nome.text = member.name
    }


}
