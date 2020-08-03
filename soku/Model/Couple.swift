//
//  Couple.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class Couple {
    
    let id : String
    let userID : String
    let date : Date
    let person1 : Person
    let person2 : Person
    
    var relationUrl : URL?
    
    var goodCount = 0
    var badCount = 0
    
    init(coupleId : String, userId : String,person_1 : Person,person_2 : Person, urlString : String?, date : Date) {
        self.id = coupleId
        self.userID = userId
        self.person1 = person_1
        self.person2 = person_2
        
        self.date = date
        
        if urlString != nil {
            self.relationUrl = URL(string: urlString!)
        }
         
    }
    
}
