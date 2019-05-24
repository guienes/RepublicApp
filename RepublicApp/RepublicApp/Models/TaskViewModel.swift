//
//  TaskViewModel.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 16/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation



class TaskViewModel {
    
    var tasks = [Task]()
    var myTasks = [Task]()
    var recorrenteTask = [Task]()
    var ocasionalTask = [Task]()
    var requestNewTask = Task()
    var members = [User]()
    var selectedMemberId = ""
    var isRecorrente = true
    var isYes = true
    
    func mockData() {
        let task = Task()
        task.name = "Arrumar o quarto"
        task.isRecorrent = false
        task.designation = UserDefaults.standard.string(forKey: USER_ID)
        task.desc = "Colocar tudo em ordem!"
        tasks.append(task)
        
        let task1 = Task()
        task1.name = "Fazer a janta"
        task.desc = "Fazer macarrão com salsicha"
        task1.isRecorrent = false
        task1.designation = ""
        tasks.append(task1)
        
        let task2 = Task()
        task2.name = "Lavar a louça"
        task2.desc = "Lavar todos os pratos"
        task2.isRecorrent = true
        task2.designation = ""
        tasks.append(task2)
        
        separateTasks()
    }
    
    func mockNaoDesignado() {
        let task1 = Task()
        task1.name = "Fazer a janta"
        task1.desc = "Fazer macarrão com salsicha"
        task1.isRecorrent = false
        task1.designation = ""
        recorrenteTask.append(task1)
        
        let task2 = Task()
        task2.name = "Lavar a louça"
        task2.desc = "Lavar todos os pratos"
        task2.isRecorrent = true
        task2.designation = ""
        ocasionalTask.append(task2)
    }
    
    func separateTasks() {
        for task in tasks {
            if task.designation == UserDefaults.standard.string(forKey: USER_ID) {
                myTasks.append(task)
            } else if task.isRecorrent ?? false {
                recorrenteTask.append(task)
            } else {
                ocasionalTask.append(task)
            }
        }
        tasks.removeAll()
    }
    
    func getNumberOfMembers() -> Int {
        return members.count
    }
    
    func getMemberForRow(index: Int) -> User {
        return members[index]
    }
    
    func getNumberOfRows(tableIndex: Int) -> Int {
        if tableIndex == 1 {
            return myTasks.count
        } else if tableIndex == 2 {
            if isRecorrente {
                return recorrenteTask.count
            }
        }
        return ocasionalTask.count
    }
    
    func getTaskForIndex(tableIndex: Int, index: Int) -> Task {
        if tableIndex == 1 {
            return myTasks[index]
        } else if tableIndex == 2 {
            if isRecorrente {
                return recorrenteTask[index]
            }
        }
            return ocasionalTask[index]
    }

    func getIdForRow(index: Int) -> String {
        if self.isRecorrente {
            return self.recorrenteTask[index].id ?? ""
        }
        return self.ocasionalTask[index].id ?? ""
    }
}
