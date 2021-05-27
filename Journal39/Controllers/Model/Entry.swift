//
//  Entry.swift
//  Journal39
//
//  Created by Colton Swapp on 5/24/21.
//

import UIKit

class Entry {
    
    var body: String
    var title: String
    var uuid: String
    
    init(body: String, title: String, uuid: String = UUID().uuidString) {
        self.body = body
        self.title = title
        self.uuid = uuid
    }
    
}
