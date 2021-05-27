//
//  EntryController.swift
//  Journal39
//
//  Created by Colton Swapp on 5/24/21.
//

import UIKit
// Now we import the good stuff.
import FirebaseFirestore

class EntryController {
    
    // MARK: - SHARED INSTANCE
    static let sharedInstance = EntryController()
    
    // MARK: - SOURCE OF TRUTH
    var entries: [Entry] = []
    
    // MARK: - DATABASE REF
    // Here is our first taste of something that is remotely relating to Firebase. Create this reference to our database so that we will not have to speciy Firestore.firestore() everytime we are accessing the database for something.
    let db = Firestore.firestore()
    
    // MARK: - CRUDDIES
    func createEntry(entry: Entry) {
        let entryToAdd: Entry = entry
        
        // Make a reference to the document that we will be setting the data of.
        // Remember that our database is made up of collections, and collections have documents, and documents have data.
        let entryRef = db.collection("entries").document(entryToAdd.uuid)
        // Now that we have specified the collection where this document will live, as well as the name of this document(entryToAdd.uuid), we can set the data on this document using the setData() method.
        // Use key value pairs to place each property that makes up an entry and set it as data on the document.
        entryRef.setData(["body" : entryToAdd.body,
                              "title" : entryToAdd.title,
                              "uuid": entryToAdd.uuid])
        
        // Add this newly created entry onto our local source of truth, and that's a wrap.
        entries.append(entryToAdd)
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        // When it comes to fetching the entries that live in our "entries" collection, we are going to add a SnapshotListener.
        // Think of a Snapshot as taking a screenshot of the data, so that we can decode it into our individual entries.
        db.collection("entries").addSnapshotListener { snapshot, error in
            self.entries = []
            
            if let error = error {
                print("Error in \(#function): On Line \(#line) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            
            if let snapshot = snapshot {
                // A snapshot has an array of documents, which we will now loop through to grab the data.
                for doc in snapshot.documents {
                    let entryData = doc.data()
                    let title = entryData["title"] as? String ?? ""
                    let body = entryData["body"] as? String ?? ""
                    let uuid = entryData["uuid"] as? String ?? ""
                    
                    // Now we create an entry that is made up of the individual constants that we just created.
                    let entry = Entry(body: body, title: title, uuid: uuid)
                    
                    // Append our newly created entry to the source of truth.
                    self.entries.append(entry)
                }
                // Now we call our completion so that we know that the fetch has completed successfully.
                completion(true)
            }
        }
    }
    
    func updateEntry(entry: Entry) {
        // This is awfully similar to simply creating an entry, we just reset the data.
        let entryRef = db.collection("entries").document(entry.uuid)
        entryRef.setData(["body" :  entry.body,
                          "title" : entry.title], merge: true)
        // The only difference here is that we will never be updating the UUID, so we do not need to include that. 
    }
    
    
}
