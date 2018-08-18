//
//  ProfileViewModel.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/18/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var profiles: [Profile] = []
    
    func fetchProfiles() {
        if profiles.count < 1 {
            let p1 = Profile(identifier: 123, firstName: "Jeff", lastName: "Lebowski", profilePicture: "null", age: 45, hobbies: ["bowling", "listening to music", "hot baths"])
            let p2 = Profile(identifier: 34, firstName: "Bunny", lastName: "Lebowski", profilePicture: "null", age: 22, hobbies: ["cosmetology", "road trips", "acting"])
            let p3 = Profile(identifier: 436, firstName: "Walter", lastName: "", profilePicture: "null", age: 43, hobbies: ["bowling", "guns", "war memorabilia"])
            
            profiles.append(p1)
            profiles.append(p2)
            profiles.append(p3)
        }
    }
    
}
