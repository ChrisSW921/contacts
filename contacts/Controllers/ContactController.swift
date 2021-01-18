//
//  ContactController.swift
//  contacts
//
//  Created by Chris Withers on 1/16/21.
//

import Foundation

class ContactController {
    
    static var shared = ContactController()
    
    var contacts: [Contact] = []
    
    //MARK: - CRUD functions
    
    func addNewContact(first: String, last: String, phone: String, email: String){
        contacts.append(Contact(firstName: first, lastName: last, phone: phone, email: email))
        saveToPersistenceStore()
    }
    
    func deleteContact(contact: Contact){
        guard let index = contacts.firstIndex(of: contact) else { return }
        contacts.remove(at: index)
        saveToPersistenceStore()
    }
    
    func updateContact(contact: Contact, first: String?, last: String?, phone: String?, email: String?){
        if let newFirst = first {
            contact.firstName = newFirst
        }
        if let newLast = last {
            contact.lastName = newLast
        }
        if let newPhone = phone {
            contact.phone = newPhone
        }
        if let newEmail = email {
            contact.email = newEmail
        }
        saveToPersistenceStore()
    }
    
    
    
    //MARK:- Persistence functions
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("contacts.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: fileURL())
        }catch{
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: fileURL())
            contacts = try JSONDecoder().decode([Contact].self, from: data)
        }catch {
            print("Error loading data \(error.localizedDescription)")
        }
        
    }
    
}
