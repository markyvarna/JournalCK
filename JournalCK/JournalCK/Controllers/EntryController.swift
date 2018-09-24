//
//  EntryController.swift
//  JournalCK
//
//  Created by Markus Varner on 9/24/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //Sigleton
    static let shared = EntryController()
    //SOT
    var entries: [Entry] = []
    
    
    //MARK: - CRUD
    
    //Create
    func createNewWith(title: String, body: String) {
        
        let entry = Entry(title: title, body: body)
        entries.append(entry)
        saveEntryToCloud(entry: entry)
        
    }
    
    //Save
    func saveEntryToCloud(entry: Entry) {
        let record = entry.ckRecord
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print("🤮Error saving to CloudKit \(error.localizedDescription)")
            }
            
            if let record = record {
                guard let entry = Entry(ckrecord: record) else {return}
                self.entries.append(entry)
                print("💸Record Saved: \(record)")
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool)-> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Entry.TypeKey, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {completion(false); return}
            let entries = records.compactMap{Entry(ckrecord: $0)}
            self.entries = entries
            completion(true)
        }
        
    }
    
}
