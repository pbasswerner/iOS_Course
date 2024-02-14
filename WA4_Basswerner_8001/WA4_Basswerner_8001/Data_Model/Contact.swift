//
//  Contact.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/14/24.
//

import Foundation

struct Contact {
    var name: String?
    var phoneNumber: String?
    var phoneType: String?
    var email: String?
    var address: String?
    var cityState: String?
    var zip: String?
    
    init(name: String? = nil, phoneNumber: String? = nil, phoneType: String? = nil, email: String? = nil, address: String? = nil, cityState: String? = nil, zip: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
        self.email = email
        self.address = address
        self.cityState = cityState
        self.zip = zip
    }
}
