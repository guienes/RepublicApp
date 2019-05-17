//
//  MembersTableViewCell.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell {

    @IBOutlet weak var photoViewUIView: UIView!
    @IBOutlet weak var NameUILabel: UILabel!
    @IBOutlet weak var TelUserUILabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(user: User) {
        self.NameUILabel.text = user.name
        self.TelUserUILabel.text = user.phone
    }
    
}
