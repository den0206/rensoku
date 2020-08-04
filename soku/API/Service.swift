//
//  Service.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase

class Service {
    
    static func anonymousLogin(completion :  @escaping(Error?) -> Void) {
        Auth.auth().signInAnonymously { (result, error) in
            
            
            if error != nil {
                print(error!.localizedDescription)
                completion(error)
                return
            }
            
            guard let user = result?.user else {return}
            let isAnonimous = user.isAnonymous
            print(isAnonimous)
            let uid = user.uid
            
            UserDefaults.standard.setValue(uid, forKey: kCURRENTUID)
            UserDefaults.standard.synchronize()
            return
        }
    }
    
    static func saveCouple(couple : Couple, relationUrl : String?, completion :  @escaping(Error?) -> Void) {
        
        [couple.person1,couple.person2].forEach { (person) in
            
            let personValue = [ kNAME : person.name,
                                         kPROFFESION : person.proffesion,
                                         kSEX :person.sex]
            
            firebeseReference(.Person).document(person.name).setData(personValue,merge: true)
            
            firebeseReference(.Person).document(person.name).updateData([kCOUPLEIDS : FieldValue.arrayUnion([couple.id])])
            
            
        }
        
        
        var value = [kCOUPLEID : couple.id,
                     kUID : couple.userID,
                     kDATE : Timestamp(date: couple.date),
                     kPERSON1NAME : couple.person1.name,
                     kPERSON1PROFFESION : couple.person1.proffesion,
                     kPERSON1SEX :couple.person1.sex,
                     kPERSON2NAME : couple.person2.name,
                     kPERSON2PROFFESION : couple.person2.proffesion,
                     kPERSON2SEX :couple.person2.sex ] as [String : Any]
        
        
        if relationUrl != nil {
            value[kRELATIONURL] = relationUrl!
        }
        
       
        
        firebeseReference(.Couple).document(couple.id).setData(value, completion: completion)
        
    }
}



//        let person1Value = [ kNAME : couple.person1.name,
//                             kPROFFESION : couple.person1.proffesion,
//                             kSEX :couple.person1.sex]
//
//        let person2Value = [ kNAME : couple.person2.name,
//                             kPROFFESION : couple.person2.proffesion,
//                             kSEX :couple.person2.sex]
//
//
//
//        firebeseReference(.Person).document(couple.person1.name).setData(person1Value,merge: true)
//
//        firebeseReference(.Person).document(couple.person2.name).setData(person2Value)
//
//        firebeseReference(.Person).document(couple.person1.name).updateData([kCOUPLEIDS : FieldValue.arrayUnion([couple.id]) ])
