//
//  FirebaseReference.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import FirebaseFirestore

enum Reference : String {
    case Couple
    case Person
}

func firebeseReference(_ reference : Reference) -> CollectionReference {
    
    return Firestore.firestore().collection(reference.rawValue)
}
