//
//  EntryTableViewCell.swift
//  Journal39
//
//  Created by Colton Swapp on 5/25/21.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var entryLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            guard let entry = entry else { return }
            configure(for: entry)
        }
    }
    
    func configure(for entry: Entry) {
        entryLabel.text = entry.title
    }

}
