//
//  CollectionTasks.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

protocol CellTasksViewControllerDelegate {
    func didDelete(id: String)
}

class CellTasksViewController: UICollectionViewCell{
    
    @IBOutlet weak var CiruculoDeFogo: UIButton!
    
    @IBOutlet weak var CompleteTaskUIImageView: UIImageView!
    @IBOutlet weak var TaskDescriptionUILabel: UILabel!
    @IBOutlet weak var TaskTitleUILabel: UILabel!
    
    var delegate: CellTasksViewControllerDelegate?
    var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(task: Task) {
        TaskTitleUILabel.text = task.name
        TaskDescriptionUILabel.text = task.desc
        self.id = task.id
        self.CompleteTaskUIImageView.isHidden = true
    }
    
    
    @IBAction func didTapCheck(_ sender: Any) {
        self.CompleteTaskUIImageView.isHidden = false
        self.delegate?.didDelete(id: self.id ?? "")
    }
    
}
