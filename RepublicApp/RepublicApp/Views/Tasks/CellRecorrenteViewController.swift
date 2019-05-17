//
//  CellRecorrenteViewController.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 15/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class CellRecorrenteViewController:UITableViewCell{
    
    @IBOutlet weak var TarefaUILabel: UILabel!
    @IBOutlet weak var DescriptionUILabel: UILabel!
    @IBOutlet weak var PersonImageUIImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(task: Task) {
        self.DescriptionUILabel.text = task.desc
        self.TarefaUILabel.text = task.name
    }
}
