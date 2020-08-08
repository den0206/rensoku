//
//  Couple.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase

class Couple {
    
    let id : String
    let userID : String
    var date : Date
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
    
    init(json : [String : Any], persons : [Person]) {

        self.id = json[kCOUPLEID] as? String ?? ""
        self.userID = json[kUID] as? String ?? ""
        
        self.person1 = persons[0]
        self.person2 = persons[1]
        
        if json[kRELATIONURL] != nil {
            self.relationUrl = URL(string: json[kRELATIONURL] as! String )
        }
         

        if let date = json[kDATE] as? Timestamp {
            self.date = date.dateValue()
        } else {
            self.date = json[kDATE] as? Date ?? Date()
        }
    }
    
}
