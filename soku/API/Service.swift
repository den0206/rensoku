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
}
