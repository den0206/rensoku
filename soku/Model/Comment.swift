//
//  Comment.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase

struct Comment {
    
    let id : String
    let text : String
    let date : Date
    let userId : String

    let couple : Couple
    
    init(id : String, text : String, date : Date, userId : String,couple : Couple) {
        self.id = id
        self.text = text
        self.date = date
        self.userId = userId
        self.couple = couple
    }
    
    init(json : [String : Any], commentId :String, couple : Couple) {
        self.id = commentId
        self.text = json[kCOMMENT] as? String ?? ""
        self.userId = json[kUID] as? String ?? ""
        self.couple = couple
       
        
        if let date = json[kDATE] as? Timestamp {
            self.date = date.dateValue()
        } else {
            self.date = json[kDATE] as? Date ?? Date()
        }
    }
}
