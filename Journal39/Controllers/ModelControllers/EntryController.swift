//
//  EntryController.swift
//  Journal39
//
//  Created by Colton Swapp on 5/24/21.
//

import UIKit
import FirebaseFirestore

class EntryController {
    
    // MARK: - SHARED INSTANCE
    static let sharedInstance = EntryController()
    
    // MARK: - SOURCE OF TRUTH
    var entries: [Entry] = []
    
    // MARK: - DATABASE REF
    let db = Firestore.firestore()
    
    // MARK: - CRUDDIES
    func createEntry(entry: Entry) {
        let entryToAdd: Entry = entry

        let entryRef = db.collection("entries").document(entryToAdd.uuid)
        entryRef.setData(["body" : entryToAdd.body,
                              "title" : entryToAdd.title,
                              "uuid": entryToAdd.uuid])
        entries.append(entryToAdd)
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        db.collection("entries").addSnapshotListener { snapshot, error in
            self.entries = []
            
            if let error = error {
                print("Error in \(#function): On Line \(#line) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            
            if let snapshot = snapshot {
                for doc in snapshot.documents {
                    let entryData = doc.data()
                    let title = entryData["title"] as? String ?? ""
                    let body = entryData["body"] as? String ?? ""
                    let uuid = entryData["uuid"] as? String ?? ""
                    
                    let entry = Entry(body: body, title: title, uuid: uuid)
                    
                    self.entries.append(entry)
                }
                completion(true)
            }
        }
    }
    
   func updateEntry(entry: Entry) {
        db.collection("entries").document(entry.uuid).setData(["body" :  entry.body,
                                                               "title" : entry.title,
                                                               "uuid" : entry.uuid], merge: true)
    }
    
    
}
