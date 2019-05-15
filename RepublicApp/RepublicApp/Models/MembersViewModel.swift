//
//  MembersViewModel.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 15/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit


class MembersViewModel {
    var members = [User]()
    
    func getNumberOfRows() -> Int {
        return members.count
    }
    
    func getMemberForIndex(index:Int) -> User {
        return members[index]
        
    }
    
    
}
