//
//  TaskViewController.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class TaskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var TasksTableView: UITableView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskModel", for: indexPath)
        return aCell
        
    }
    
//    func TasksTableView(
    
    
    @IBAction func AddTaskUIButton(_ sender: Any) {
    }
    
    
    @IBAction func EditTaskUIButton(_ sender: Any) {
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        TasksTableView.delegate = self
        TasksTableView.dataSource = self
        
        
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bCell = TasksTableView.dequeueReusableCell(withIdentifier: "CellRecorrenteViewController", for: indexPath)
        
        return bCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}

