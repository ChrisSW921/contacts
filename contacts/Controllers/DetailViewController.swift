//
//  DetailViewController.swift
//  contacts
//
//  Created by Chris Withers on 1/16/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty else { showAlert(didSave:false); return }
        if let currentContact = contact {
            ContactController.shared.updateContact(contact: currentContact, first: firstName, last: lastName, phone: phoneTextField.text, email: emailTextField.text)
            showAlert(didSave: true)
        }else {
            ContactController.shared.addNewContact(first: firstName, last: lastName, phone: phoneTextField.text!, email: emailTextField.text!)
            showAlert(didSave: true)
        }
        
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        firstNameTextField.isEnabled = true
        lastNameTextField.isEnabled = true
        phoneTextField.isEnabled = true
        emailTextField.isEnabled = true
    }
    
    
    
    func updateView(){
        firstNameTextField.isEnabled = false
        lastNameTextField.isEnabled = false
        phoneTextField.isEnabled = false
        emailTextField.isEnabled = false
        
        firstNameTextField.text = contact?.firstName
        lastNameTextField.text = contact?.lastName
        if let phone = contact?.phone {
            phoneTextField.text = phone
        }
        if let email = contact?.email {
            emailTextField.text = email
        }
    }
    
    func showAlert(didSave: Bool) {
        let alertController = UIAlertController(title: didSave ? "Saved" : "Error", message: didSave ? "New Contact Saved!" : "Please fill out first and last name", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: didSave ? "Awesome!" : "Ok" , style: .default) { (UIAlertAction) in
            if didSave {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
