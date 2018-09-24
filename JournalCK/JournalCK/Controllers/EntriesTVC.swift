//
//  EntriesTVC.swift
//  JournalCK
//
//  Created by Markus Varner on 9/24/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class EntriesTVC: UITableViewController {

    
    //property observer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
    
        cell.textLabel?.text = entry.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func updateView() {
        
        EntryController.shared.fetchEntries { (success) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    //MARK: - Actions
    
    @IBAction func addNewEntryBP(_ sender: UIBarButtonItem) {
        
        
        
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewEntry" {
            let destinationvc = segue.destination as? DetailVC
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationvc?.entry = EntryController.shared.entries[indexPath.row]
            
        }
        
    }
    

}
