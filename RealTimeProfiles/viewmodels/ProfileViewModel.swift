//
//  ProfileViewModel.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/18/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ProfileViewModel {
    
    var profiles: [Profile] = []
    
    func fetchProfiles() {
//        if profiles.count < 1 {
//            let p1 = Profile(identifier: 123, firstName: "Jeff", lastName: "Lebowski", profilePicture: "null", age: 45, hobbies: ["bowling", "listening to music", "hot baths"], gender: "male")
//            let p2 = Profile(identifier: 34, firstName: "Bunny", lastName: "Lebowski", profilePicture: "null", age: 22, hobbies: ["cosmetology", "road trips", "acting"], gender: "non-binary")
//            let p3 = Profile(identifier: 436, firstName: "Walter", lastName: "", profilePicture: "null", age: 43, hobbies: ["bowling", "guns", "war memorabilia"], gender: "female")
//
//            profiles.append(p1)
//            profiles.append(p2)
//            profiles.append(p3)
//        }
    }
    
//    func getProfiles() {
//        var ref = Database.database().reference()
//
//        ref.child("")
//    }
    
    func createProfile(withProfile profile: Profile) {
        
        let ref = Database.database().reference().child("profiles").childByAutoId()
        
        ref.setValue(profile.getData()) { (error, reference) in
            if let _ = error {
                print("shit happened!")
            } else {
                print("HELL YEAH SUCCESS BABY")
            }
        }
    }
    
//    func fetchProfile(byId identifier: String) {
//        let ref = Database.database().reference().child("users")
//
//
//    }
}
