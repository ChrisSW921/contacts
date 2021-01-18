//
//  ContactsTableViewController.swift
//  contacts
//
//  Created by Chris Withers on 1/16/21.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var sections: [[Contact]] = []
    var currentSectionLetters: [String:[Contact]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        getSectionLetters()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currentSectionLetters.keys.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = Array(currentSectionLetters.keys.sorted())[section]
        label.backgroundColor = .lightGray
        label.textColor = .white
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let letterKeys = Array(currentSectionLetters.keys.sorted())
        return currentSectionLetters[Array(letterKeys)[section]]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let keys = Array(currentSectionLetters.keys.sorted())
        
        let contact = currentSectionLetters[keys[indexPath.section]]![indexPath.row]
        cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let keys = Array(currentSectionLetters.keys.sorted())
            
            let contactToDelete = currentSectionLetters[keys[indexPath.section]]![indexPath.row]
            ContactController.shared.deleteContact(contact: contactToDelete)
            currentSectionLetters[keys[indexPath.section]]?.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            getSectionLetters()
        } 
    }
    
    //MARK: - Helper Functions
    func getSectionLetters(){
        currentSectionLetters = [:]
        for contact in ContactController.shared.contacts {
            if !currentSectionLetters.keys.contains(String(contact.firstName.prefix(1))) {
                currentSectionLetters[String(contact.firstName.prefix(1))] = []
                currentSectionLetters[String(contact.firstName.prefix(1))]?.append(contact)
            }else {
                currentSectionLetters[String(contact.firstName.prefix(1))]?.append(contact)
            }
        }
        tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContact"{
            let keys = Array(currentSectionLetters.keys.sorted())
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.contact = currentSectionLetters[keys[indexPath.section]]![indexPath.row]
        }
    }


}
