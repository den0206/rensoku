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
            completion(nil)
        }
    }
    
    static func saveCouple(couple : Couple, relationUrl : String?, completion :  @escaping(Error?) -> Void) {
        
        let persons =  [couple.person1,couple.person2]
        
        persons.forEach { (person) in
            
            let personValue = [ kNAME : person.name,
                                kPROFFESION : person.proffesion,
                                kSEX :person.sex]
            
            firebeseReference(.Person).document(person.name).setData(personValue,merge: true)
            
            firebeseReference(.Person).document(person.name).updateData([kCOUPLEIDS : FieldValue.arrayUnion([couple.id])])
            
            
        }
        let personNames =  [couple.person1.name,couple.person2.name]
        
        var value = [kCOUPLEID : couple.id,
                     kUID : couple.userID,
                     kDATE : Timestamp(date: couple.date),
                     kPERSONS : personNames] as [String : Any]
        
//        var value = [kCOUPLEID : couple.id,
//                     kUID : couple.userID,
//                     kDATE : Timestamp(date: couple.date),
//                     kPERSON1NAME : couple.person1.name,
//                     kPERSON2NAME : couple.person2.name] as [String : Any]
        

        
        
        if relationUrl != nil {
            value[kRELATIONURL] = relationUrl!
        }
        
       
        
        firebeseReference(.Couple).document(couple.id).setData(value, completion: completion)
        
    }
    
   
}

class CoupleService {
    
    static func fetchCouples(firstLoad : Bool, limit : Int, lastDocument : DocumentSnapshot?, completion :  @escaping(_ couples : [Couple], _ error : Error?, _ lastDocument : DocumentSnapshot?) -> Void ) {
        
        var query : Query!
        var couples = [Couple]()
        
        if firstLoad {
            query = firebeseReference(.Couple).order(by: kDATE, descending: false).limit(to: limit)
        } else {
            
            guard let lastDocument = lastDocument else {return}
            query = firebeseReference(.Couple).order(by: kDATE, descending: false).start(afterDocument: lastDocument).limit(to: limit)
        }
        
        guard query != nil  else { completion(couples, nil, nil); return }
        
        query.getDocuments { (snapshot, error) in
            
            if error != nil {
                completion(couples, error, nil)
                return
            }
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                
                let lastDocument = snapshot.documents.last
                
                snapshot.documents.forEach { (doc) in
                    
                    let data = doc.data()
                    let person1Name = (doc[kPERSONS] as! [String])[0]
                    let person2Name = (doc[kPERSONS] as! [String])[1]
                    
                    // let person1Name = doc[kPERSON1NAME] as! String
                    // let person2Name = doc[kPERSON2NAME] as! String
                    
                    ///上に"Man"
                    fetchPersons(names: [person1Name,person2Name]) { (persons) in
                        let sortd = persons.sorted { (lperson, rpeson) -> Bool in
                            
                            if lperson.sex == "Man" {
                                return true
                            }
                            
                            return false
                        }
                                            
                        let couple = Couple(json: data, persons: sortd)
                        
                        couples.append(couple)
                        
                        if couples.count == snapshot.documents.count {
                            completion(couples,nil, lastDocument)
                        }
                        
                    }
                    
                    
                    
                }
                
                
            } else {
                completion(couples, nil, nil)
            }
        }
        
    }
    
    static func fetchPersons(names : [String], completion :  @escaping([Person]) -> Void) {
        
        var persons = [Person]()
        
        
        for (index , name) in names.enumerated() {

            firebeseReference(.Person).document(name).getDocument { (snapshot, error) in

                guard let snapshot = snapshot else {return}

                if snapshot.exists {
                    let dic = snapshot.data()!
                    let person = Person(json: dic)
                    
                    

                    persons.append(person)

                    if persons.count == names.count {
                        completion(persons)
                    }
                }
            }
        }
    }
    
    static func fetchAllPerson(filter : String?, completion :  @escaping([Person]) -> Void) {
        
        var query : Query!
        
        switch filter {
        case kMAN:
            query = firebeseReference(.Person).whereField(kSEX, isEqualTo: "Man")
        case kWOMAN :
            query = firebeseReference(.Person).whereField(kSEX, isEqualTo: "Woman")

        default:
            query = firebeseReference(.Person)
        }
        
        query.getDocuments { (snapshot, error) in
            var persons = [Person]()
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                
                snapshot.documents.forEach { (doc) in
                    let data = doc.data()
                    let person = Person(json: data)
                    
                    persons.append(person)
                    
                    if persons.count == snapshot.documents.count {
                        completion(persons)
                    }
                }
            } else {
                completion(persons)
            }
        }
    }
    
    static func fetchCoupleFromPeson(person : Person, completion :  @escaping([Couple]) -> Void) {
        
        var couples = [Couple]()

        firebeseReference(.Couple).whereField(kPERSONS, arrayContains: person.name) .getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                snapshot.documents.forEach { (document) in
                    let data = document.data()
                    let peson1Name = person.name
                    let peson2Name : String = (data[kPERSONS] as! [String])[0] == person.name ? (data[kPERSONS] as! [String])[1] : (data[kPERSONS] as! [String])[0]
                    
                    fetchPersons(names: [peson1Name,peson2Name]) { (persons) in
                         /// 上にメインパーソン
                        let sortd = persons.sorted { (lperson, rpeson) -> Bool in
                            if lperson.name == person.name {
                                return true
                            }
                            
                            return false
                        }
                        
                        let couple = Couple(json: data, persons: sortd)
                        
                        couples.append(couple)
                        
                        if couples.count == snapshot.documents.count {
                            completion(couples)
                        }
                        
                    }
                    
                }
            } else {
                print("empty")
            }
            
        }
        
    }
    
    //MARK: - Vote
    
    static func uploadVote(coupleId : String, like : Bool, completion :  @escaping(Error?) -> Void) {
        
        guard currentUID() != "" else {return}
        
        let values = [kCOUPLEID : coupleId,
                      kUID : currentUID(),
                      kLIKEDVOTE : like
            ] as [String : Any]
        
        
        firebeseReference(.Couple).document(coupleId).collection(kVOTE).document(currentUID()).setData(values, merge: false, completion: completion)
        
        if like {
            firebeseReference(.Couple).document(coupleId).updateData([kGOODCOUNT : FieldValue.increment(Int64(1))])
        } else {
            firebeseReference(.Couple).document(coupleId).updateData([kBADCOUNT : FieldValue.increment(Int64(1))])
        }
    }
    
    static func checkVoted(couple : Couple, completion :  @escaping(_ voted : Bool) -> Void) {
        
        guard currentUID() != "" else {return}
        
        firebeseReference(.Couple).document(couple.id).collection(kVOTE).document(currentUID()).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            completion(snapshot.exists)
        }
        
    }
    
    //MARK: - Comments
    
    static func uploadComments(comment : Comment, couple : Couple, completion :  @escaping(Error?) -> Void) {
        
        // TODO: - upload firebase
        
        let value = [kUID : comment.userId,
                     kDATE : Timestamp(date: comment.date),
                     kCOMMENT : comment.text,
                     kCOUPLEID : couple.id] as [String : Any]

        
        firebeseReference(.Couple).document(couple.id).collection(kCOMMENT).document(comment.id).setData(value, completion: completion)
        
    }
    
    static func fetchComments(couple : Couple, isInitial : Bool, limit : Int, lastDocument : DocumentSnapshot?, completion :  @escaping(_ comments : [Comment], _ error : Error?, _ lastDocument : DocumentSnapshot?) -> Void) {
        
        let firestore = Firestore.firestore()
        var query : Query!
        var comments = [Comment]()
        
        if isInitial {
            query = firestore.collectionGroup(kCOMMENT).whereField(kCOUPLEID, isEqualTo: couple.id).order(by: kDATE, descending: true).limit(to: limit)
        } else {
            guard let lastDocument = lastDocument else {return}
            
            query = firestore.collectionGroup(kCOMMENT).whereField(kCOUPLEID, isEqualTo: couple.id).order(by: kDATE, descending: true).start(afterDocument: lastDocument).limit(to: limit)
        }
        
        guard query != nil else {
            print("No Query")
            completion(comments,nil, nil)
            
            return
        }
        
        query.getDocuments { (snapshot, error) in
            
            if error != nil {
                completion(comments,error,nil)
                return
            }
            
            guard let snapshot = snapshot else {return}
            
            let lastDocument = snapshot.documents.last
            snapshot.documents.forEach { (document) in
                
                let documentId = document.documentID
                let date = document.data()
                let comment = Comment(json: date, commentId: documentId, couple: couple)
                
                comments.append(comment)
                
                if comments.count == snapshot.documents.count {
                    completion(comments,nil,lastDocument)
                }
                
            }
            
        }
        
        
    }

}


