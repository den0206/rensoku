//
//  Person.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct Person {
    let name : String
    let proffesion : String
    let sex : String
    
    init(name : String, proffesion : String, sex : String) {
        
        self.name = name
        self.proffesion = proffesion
        self.sex = sex
    }
    
    init(json : [String : Any]) {
        self.name = json[kNAME] as? String ?? ""
        self.proffesion = json[kPROFFESION] as? String ?? ""
        self.sex = json[kSEX] as? String ?? ""
    }
}
