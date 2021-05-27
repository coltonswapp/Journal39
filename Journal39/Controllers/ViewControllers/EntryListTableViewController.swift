//
//  EntryListTableViewController.swift
//  Journal39
//
//  Created by Colton Swapp on 5/25/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    // MARK: - Helper functions
    func setup() {
        DispatchQueue.main.async {
            EntryController.sharedInstance.fetchEntries { success in
                if success {
                    print("Entry count: \(EntryController.sharedInstance.entries.count)")
                    self.tableView.reloadData()
                } else {
                    print("Houston, we have a problem.")
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.sharedInstance.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        
        let entry = EntryController.sharedInstance.entries[indexPath.row]
        
        cell.entry = entry

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetailVC" {
            guard let destinationVC = segue.destination as? EntryDetailView,
                  let index = tableView.indexPathForSelectedRow else { return }
            let entryToSend = EntryController.sharedInstance.entries[index.row]
            destinationVC.entry = entryToSend
        }
    }
    

}
