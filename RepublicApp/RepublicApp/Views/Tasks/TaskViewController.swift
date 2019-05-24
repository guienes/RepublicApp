//
//  TaskViewController.swift
//  RepublicApp
//
//  Created by Amaury A V A Souza on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class TaskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var botConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardView: RoundButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var TasksTableView: UITableView!
    @IBOutlet weak var recorrenteLabel: UILabel!
    @IBOutlet weak var ocasionalLabel: UILabel!
    @IBOutlet weak var recorrenteView: UIView!
    @IBOutlet weak var ocasionalView: UIView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var membersCollectionView: UICollectionView!
    
    let model = TaskViewModel()
    let memberCellName = "MembersCollectionViewCell"
    let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissTextField))

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        membersCollectionView.delegate = self
        membersCollectionView.dataSource = self
        TasksTableView.delegate = self
        TasksTableView.dataSource = self
//        itemTextField.delegate = self
//        descTextField.delegate = self
        viewTaps()
//        model.mockNaoDesignado()
        self.itemTextField.attributedPlaceholder = NSAttributedString(string: "Item",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.descTextField.attributedPlaceholder = NSAttributedString(string: "Descrição",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        model.mockData()
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get()
        membersGet()
    }
    
    func registerNib(){
        membersCollectionView.register(UINib(nibName: memberCellName, bundle: nil), forCellWithReuseIdentifier: memberCellName)
    }
    
    func get() {
        self.model.tasks.removeAll()
        self.model.recorrenteTask.removeAll()
        self.model.ocasionalTask.removeAll()
        self.model.myTasks.removeAll()
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        getTasks(idRepublic: UserDefaults.standard.string(forKey: REPUBLIC_ID) ?? "") { (result, error, tasks) in
            if !called {
                if let ta = tasks {
                    self.model.tasks = ta
                    called = true
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            //            let check = response["result"] as? String
            self.model.separateTasks()
            self.TasksTableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func membersGet() {
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
                self.model.members = response
                self.membersCollectionView.reloadData()
            } else {
                //error
            }
        }
    }
    
    func delete(id: String) {
        var response: [String : Any]?
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        deleteTask(idProduct: id) { (result, error) in
            if !called {
                if let re = result {
                    response = re
                    called = true
                    group.leave()
                    
                }
            }
        }
        group.notify(queue: .main) {
            //            let check = response["result"] as? String
            self.get()
        }
    }
    
    func viewTaps() {
        let recorrenteTap = UITapGestureRecognizer(target: self, action: #selector(didTapRecorrente))
        self.recorrenteView.addGestureRecognizer(recorrenteTap)
        let ocasionalTap = UITapGestureRecognizer(target: self, action: #selector(didTapOcasional))
        self.ocasionalView.addGestureRecognizer(ocasionalTap)
        
        let tapYes = UITapGestureRecognizer(target: self, action: #selector(didTapYes))
        let tapNo = UITapGestureRecognizer(target: self, action: #selector(didTapNo))
        
        self.yesView.addGestureRecognizer(tapYes)
        self.noView.addGestureRecognizer(tapNo)
    }
    
    @objc func dismissTextField() {
        self.itemTextField.endEditing(true)
        self.descTextField.endEditing(true)
    }
    
    @objc func didTapRecorrente() {
        self.recorrenteView.backgroundColor =  UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        self.recorrenteLabel.textColor = .white
        self.ocasionalView.backgroundColor = .white
        self.ocasionalLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        self.model.isRecorrente = true
        self.TasksTableView.reloadData()
    }
    
    @objc func didTapOcasional() {
        self.recorrenteView.backgroundColor =  .white
        self.recorrenteLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        self.ocasionalView.backgroundColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        self.ocasionalLabel.textColor = .white
        self.model.isRecorrente = false
        self.TasksTableView.reloadData()
    }
    
    @objc func didTapYes() {
        yesView.backgroundColor = .white
        yesLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        noView.backgroundColor = .clear
        noLabel.textColor = .white
        model.isYes = true
    }
    
    @objc func didTapNo() {
        noView.backgroundColor = .white
        noLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        yesView.backgroundColor = .clear
        yesLabel.textColor = .white
        model.isYes = false
    }
    
    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == membersCollectionView {
            return model.getNumberOfMembers()
        }
        return model.getNumberOfRows(tableIndex: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == membersCollectionView {
            let memberCell = membersCollectionView.dequeueReusableCell(withReuseIdentifier: memberCellName, for: indexPath) as! MembersCollectionViewCell
            memberCell.setup(member: self.model.getMemberForRow(index: indexPath.row), selectedId: self.model.selectedMemberId)
            return memberCell
        }
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskModel", for: indexPath) as! CellTasksViewController
        aCell.delegate = self
        aCell.setup(task: model.getTaskForIndex(tableIndex: 1, index: indexPath.row))
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == membersCollectionView {
            return CGSize(width: self.collectionView.cellForItem(at: indexPath)?.frame.width ?? 150, height: 72)
        }
        return CGSize(width: 203, height: 129)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == membersCollectionView {
            self.model.selectedMemberId = self.model.getMemberForRow(index: indexPath.row).id ?? ""
            self.membersCollectionView.reloadData()
        }
        
    }
    
    func sendAllDown() {
        self.topConstraint.constant = self.cardView.frame.height - 60
        self.botConstraint.constant = -300
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendUp))
        self.cardView.addGestureRecognizer(tap)
        addButtonOutlet.isUserInteractionEnabled = false
    }
    
    @objc func sendUp() {
        self.topConstraint.constant = 70
        self.botConstraint.constant = -40
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
        self.cardView.gestureRecognizers?.removeAll()
        addButtonOutlet.isUserInteractionEnabled = true
    }
    
    @IBAction func AddTaskUIButton(_ sender: Any) {
        sendAllDown()
    }
    
    @IBAction func createTask(_ sender: Any) {
        if let itemName = itemTextField.text, let desc = descTextField.text {
            self.model.requestNewTask.republic = UserDefaults.standard.string(forKey: REPUBLIC_ID)
            self.model.requestNewTask.desc = desc
            self.model.requestNewTask.isRecorrent = self.model.isRecorrente
            self.model.requestNewTask.name = itemName
            if self.model.selectedMemberId != ""{
                self.model.requestNewTask.designation = self.model.selectedMemberId
            }
            var response: [String : Any]?
            let group = DispatchGroup() // initialize the async
            var called = false
            group.enter()
            postTask(task: self.model.requestNewTask) { (result, error) in
                if !called {
                    if let re = result {
                        response = re
                        called = true
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                //            let check = response["result"] as? String
                if let response = response {
                    self.sendUp()
                    self.get()
                    self.TasksTableView.reloadData()
                    self.collectionView.reloadData()
                } else {
                    //error
                }
            
            }
        }
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfRows(tableIndex: 2)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bCell = TasksTableView.dequeueReusableCell(withIdentifier: "CellRecorrenteViewController", for: indexPath) as! CellRecorrenteViewController
        bCell.setup(task: model.getTaskForIndex(tableIndex: 2, index: indexPath.row))
        return bCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(id: self.model.getIdForRow(index: indexPath.row))
        }
    }
    
    
}

extension TaskViewController: CellTasksViewControllerDelegate {
    func didDelete(id: String) {
        delete(id: id)
    }
    
    
}
