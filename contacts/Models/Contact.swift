//
//  Contact.swift
//  contacts
//
//  Created by Chris Withers on 1/16/21.
//

import Foundation

class Contact: Codable {
    var firstName: String
    var lastName: String
    var phone: String?
    var email: String?
    var timeAdded: Date
    
    init(firstName: String, lastName: String, phone: String, email: String, timeAdded: Date = Date()) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.timeAdded = timeAdded
    }
}

extension Contact : Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.timeAdded == rhs.timeAdded
    }
    
    
}
