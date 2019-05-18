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
    
    func mock() {
        let user = User()
        user.name = "Felipe"
        user.phone = "(11) 973916617"
//        user.pic = "IMG_0380"
        
        members.append(user)
        
        let user1 = User()
        user1.name = "Amaury"
        user1.phone = "(11) 985551964"
//        user1.pic = "IMG_0134"
        
        members.append(user1)
        
        let user2 = User()
        user2.name = "Enes"
        user2.phone = "(11) 945360746"
//        user2.pic = "IMG_0142"
        members.append(user2)
    }
    
    func getNumberOfRows() -> Int {
        return members.count
    }
    
    func getMemberForIndex(index:Int) -> User {
        return members[index]
        
    }
    
    
}
