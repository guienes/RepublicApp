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
    
    var model = MembersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RepublicUITableView.delegate = self
        RepublicUITableView.dataSource = self
//        self.get()
    }
    
    func get() {
        var response = [User]()
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        getMembers(republicId: UserDefaults.standard.string(forKey: REPUBLIC_ID) ?? "") { (result, error, users) in
            if !called {
                if let re = users {
                    response = re
                    called = true
                    group.leave()
                    
                }
            }
        }
        group.notify(queue: .main) {
            //            let check = response["result"] as? String
            if !response.isEmpty {
                self.RepublicUITableView.reloadData()
            } else {
                //error
            }
        }
    }
}

extension MembersViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfRows() //qntd de linhas busca no model Members
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCelular = tableView.dequeueReusableCell(withIdentifier: "MembersTableViewCell") as! MembersTableViewCell
        aCelular.setup(user: model.getMemberForIndex(index: indexPath.row))
        return aCelular
    }
    
    func numberOfSections(in RepublicUITabelView: UITableView) -> Int {
        return 1
    }
}
