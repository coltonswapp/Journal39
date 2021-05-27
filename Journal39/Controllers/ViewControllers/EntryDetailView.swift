//
//  EntryDetailView.swift
//  Journal39
//
//  Created by Colton Swapp on 5/24/21.
//

import UIKit

class EntryDetailView: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    var entry: Entry?
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let bodyText = bodyTextView.text, !bodyText.isEmpty, let titleText = titleTextField.text, !titleText.isEmpty else { return }
        if let entry = entry {
            entry.body = bodyText
            entry.title = titleText
            
            EntryController.sharedInstance.updateEntry(entry: entry)
        } else {
            let newEntry = Entry(body: bodyText, title: titleText)
            EntryController.sharedInstance.createEntry(entry: newEntry)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    func setupViews() {
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 35, y: titleTextField.frame.height, width: 32, height: 2)
        bottomLine1.backgroundColor = UIColor.black.cgColor
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: -5, y: titleTextField.frame.height, width: 32, height: 2)
        bottomLine2.backgroundColor = UIColor.red.cgColor
        
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 74, y: titleTextField.frame.height, width: 90, height: 2)
        bottomLine3.backgroundColor = UIColor.blue.cgColor
        
        
        titleTextField.borderStyle = .none
        titleTextField.layer.addSublayer(bottomLine1)
        titleTextField.layer.addSublayer(bottomLine2)
        titleTextField.layer.addSublayer(bottomLine3)
        titleTextField.text = entry?.title
        bodyTextView.text = entry?.body
        bodyTextView.isScrollEnabled = false
    }


}

