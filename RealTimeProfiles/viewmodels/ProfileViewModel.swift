//
//  ProfileViewModel.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/18/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol ProfileViewModelDelegate {
    func profilesChanged()
}

class ProfileViewModel {
    
    var delegate: ProfileViewModelDelegate?
    
    var profiles: [Profile] = []
    
    func getProfiles() {
        let profilesRef = Database.database().reference(withPath: "profiles")
        
        profiles = []
        
        profilesRef.observe(DataEventType.childAdded) { snapshot in
            
            let key = snapshot.key

            if let array = snapshot.valueInExportFormat() as? [String: Any?] {
                let profile = Profile.createProfile(withData: array, identifier: key)
                
                self.profiles.append(profile)
                
                if let delegate = self.delegate {
                    delegate.profilesChanged()
                }
            }
            
        }
        
//        profilesRef.observe(.childChanged) { snapshot in
//
//        }
    }
    
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
