//
//  CollectionTasks.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class CellTasksViewController: UICollectionViewCell{
    
    @IBOutlet weak var CiruculoDeFogo: UIButton!
    
    @IBOutlet weak var CompleteTaskUIImageView: UIImageView!
    @IBOutlet weak var TaskDescriptionUILabel: UILabel!
    @IBOutlet weak var TaskTitleUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
