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
    
    static let identifierKey = "identifier"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let profileImageKey = "profileImage"
    static let ageKey = "age"
    static let hobbiesKey = "hobbies"
    static let genderKey = "gender"
    
    func getFirstNameLastName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func getLastNameFirstName() -> String {
        return "\(self.lastName), \(self.firstName)"
    }
    
    func getData() -> [String : Any?] {
        return [ Profile.firstNameKey : firstName,
                Profile.lastNameKey : lastName,
                Profile.profileImageKey : profilePicture,
                Profile.ageKey : age,
                Profile.hobbiesKey : hobbies,
                Profile.genderKey : gender ]
    }
    
    static func createProfile(withData profileData: [String : Any?], identifier: String) -> Profile {
        
        var firstName = "", lastName = "", profileImage = "", age = 0, hobbies = "", gender = ""
        
        for item in profileData {
            
            if let theValue = item.value as? String {
                switch item.key {
                case Profile.firstNameKey:
                    firstName = theValue
                    break
                case Profile.lastNameKey:
                    lastName = theValue
                    break
                case Profile.profileImageKey:
                    profileImage = theValue
                    break
                case Profile.hobbiesKey:
                    hobbies = theValue
                    break
                case Profile.genderKey:
                    gender = theValue
                    break
                default:
                    break
                }
            }else if let theValue = item.value as? Int {
                age = theValue
            }

        }
        
        let profile = Profile(identifier: identifier, firstName: firstName, lastName: lastName, profilePicture: profileImage, age: age, hobbies: hobbies, gender: gender)
            
        return profile
    }
}
