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
    
    func getProfiles(filteredBy filter: String?, value: String?) {
        
        var profilesRef: DatabaseQuery
        profiles = []

        if let filterField = filter, let filterValue = value {
            profilesRef = Database.database().reference().child("profiles").queryOrdered(byChild: filterField).queryEqual(toValue: filterValue)
        } else {
            profilesRef = Database.database().reference(withPath: "profiles")
        }
        
        profilesRef.observe(.childAdded) { snapshot in
            self.buildProfiles(fromSnapshot: snapshot)
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
            
            self.profiles = self.profiles.filter({ $0.identifier != key })
            
            if let delegate = self.delegate {
                delegate.profilesChanged()
            }
        }
    }
    
    private func buildProfiles(fromSnapshot snapshot: DataSnapshot) {
        let key = snapshot.key
        
        if let array = snapshot.valueInExportFormat() as? [String: Any?],
            key != "profiles" {
            let profile = Profile.createProfile(withData: array, identifier: key)
            
            profiles.append(profile)
        }

        if let delegate = self.delegate {
            delegate.profilesChanged()
        }
    }
    
    // MARK: - Create, update, delete calls
    
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
    
    func updateProfile(_ profile: Profile) {
        if let key = profile.identifier {
            let ref = Database.database().reference()
            let profileData = profile.getData()
            let childUpdates = ["/profiles/\(key)" : profileData]
            ref.updateChildValues(childUpdates)
        }
    }
    
    func deleteProfile(_ profile: Profile) {
        if let key = profile.identifier {
            let ref = Database.database().reference(withPath: "profiles").child(key)
            ref.removeValue()
        }
    }

    // MARK: - Other service calls
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
    
    func sortProfiles(_ sortValue: ProfileSortType) {
        
        switch sortValue {
        case ProfileSortType.AgeAscending:
            profiles.sort(by: { $0.age < $1.age })
            break
        case ProfileSortType.AgeDescending:
            profiles.sort(by: { $0.age > $1.age })
            break
        case ProfileSortType.NameAscending:
            profiles.sort(by: { $0.lastName.uppercased() < $1.lastName.uppercased() })
            break
        case ProfileSortType.NameDescending:
            profiles.sort(by: { $0.lastName.uppercased() > $1.lastName.uppercased() })
            break
        }
        
        if let delegate = self.delegate {
            delegate.profilesChanged()
        }
        
    }
    
    func filterProfiles(byGender gender: String) {
        getProfiles(filteredBy: "gender", value: gender)
    }
}
