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
    
    var isRecorrente = true
    var isYes = true
    
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
            return recorrenteTask[index]
        } else {
            return ocasionalTask[index]
        }
    }

    func getIdForRow(index: Int) -> String {
        if self.isRecorrente {
            return self.recorrenteTask[index].id ?? ""
        }
        return self.ocasionalTask[index].id ?? ""
    }
}
