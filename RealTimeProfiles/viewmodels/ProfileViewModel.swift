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
        
        profilesRef.observe(.childChanged) { snapshot in
            
            let key = snapshot.key
            
            let newProfiles = self.profiles.map({ (profile) -> Profile in
                
                if profile.identifier == key {
                    if let array = snapshot.valueInExportFormat() as? [String: Any?] {
                        let modifiedProfile = Profile.createProfile(withData: array, identifier: key)
                        return modifiedProfile
                    }
                    return profile
                }
                
                return profile
            })
            
            self.profiles = newProfiles
            
            if let delegate = self.delegate {
                delegate.profilesChanged()
            }
        }
        
        profilesRef.observe(.childRemoved) { (snapshot) in
            
            let key = snapshot.key
            
            print("SEE THAT CHILD WAS REMOVED")
        }
    }
    
    func createProfile(_ profile: Profile) {
        
        let ref = Database.database().reference().child("profiles").childByAutoId()
        
        ref.setValue(profile.getData()) { (error, reference) in
            if let _ = error {
                print("shit happened!")
            } else {
                print("HELL YEAH SUCCESS BABY")
            }
        }
    }
    
    func loadImage(fromUrl urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            do{
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return image
                }
            } catch {
                
            }
        }
        
        return UIImage(named: "rachAtTrevi-300") //default
    }
    
    func updateProfile(_ profile: Profile) {
        if let key = profile.identifier {
            let ref = Database.database().reference()
            let profileData = profile.getData()
            let childUpdates = ["/profiles/\(key)" : profileData]
            ref.updateChildValues(childUpdates)
        }
    }
    
    func deleteProfile(_ profile: Profile) {
        
    }
    
    func sortProfiles(_ sortValue: String) {
        let ref = Database.database().reference()
        let sortQuery = ref.child("profiles").queryOrdered(byChild: "age")
        print("i got here now")
    }
}
