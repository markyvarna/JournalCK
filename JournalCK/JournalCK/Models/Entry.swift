//
//  Entry.swift
//  JournalCK
//
//  Created by Markus Varner on 9/24/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    //CloudKit Keys
    static let TypeKey = "Entry"
    static let titleKey = "Title"
    static let bodyKey = "Body"
    //CKRecord
    var ckRecord: CKRecord {
        let record = CKRecord(recordType: Entry.TypeKey)
        //set the values with their designated keys
        record.setValue(title, forKey: Entry.titleKey)
        record.setValue(body, forKey: Entry.bodyKey)
        return record
    }
    
    //Properties
    let title: String
    let body: String
    
    init(title: String, body: String) {
        
        self.title = title
        self.body = body
        
    }
    
    //MARK: - Convenience Failable Initializer
    convenience init?(ckrecord: CKRecord) {
        
        guard let title = ckrecord[Entry.titleKey] as? String,
            let body = ckrecord[Entry.bodyKey] as? String else {return nil}
        self.init(title: title, body: body)
        
    }
}
