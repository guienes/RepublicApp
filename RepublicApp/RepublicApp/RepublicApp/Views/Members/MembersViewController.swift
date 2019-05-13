//
//  MembersViewController.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class MembersViewController: UIViewController {

    @IBOutlet weak var RepublicNameLabel: UILabel!
    @IBOutlet weak var RepublicNumberUILabel: UILabel!
    @IBOutlet weak var RepublicStreetUILabel: UILabel!
    @IBOutlet weak var RepublicUITableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RepublicUITableView.delegate = self
        RepublicUITableView.dataSource = self
    }
}

extension MembersViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //qntd de linhas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCelular = tableView.dequeueReusableCell(withIdentifier: "MembersTableViewCell") as! MembersTableViewCell
        
        return aCelular
        
    }
    
    func numberOfSections(in RepublicUITabelView: UITableView) -> Int {
        return 1
    }
    
}
