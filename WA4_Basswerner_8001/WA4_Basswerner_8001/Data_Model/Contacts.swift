//
//  Contacts.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/13/24.
//

import Foundation

struct Contact {
    var name: String?
    var phoneNumber: String?
    var phoneType: String?
    var email: String?
    var address: String?
    var cityStateZip: String?
    var zipcode: String?
    
    init(name: String?, phoneNumber: String?, phoneType: String?, email: String?, address: String?, cityStateZip: String?, zipcode: String?) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
        self.email = email
        self.address = address
        self.cityStateZip = cityStateZip
        self.zipcode = zipcode
    }
}
