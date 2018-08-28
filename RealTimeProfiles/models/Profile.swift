//
//  Profile.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/18/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation

struct Profile: Decodable {
    let identifier : String? //when it's null, it's new
    let firstName : String
    let lastName : String
    let profilePicture : String
    let age : Int
    // TODO: dateOfBirth
    let hobbies : String
    let gender : String
    
    func getFirstNameLastName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func getLastNameFirstName() -> String {
        return "\(self.lastName), \(self.firstName)"
    }
    
    func getData() -> [String : Any?] {
        return [ "firstName" : firstName,
                "lastName" : lastName,
                "profileImage" : profilePicture,
                "age" : age,
                "hobbies" : hobbies,
                "gender" : gender ]
    }
}
