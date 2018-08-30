//
//  ViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/15/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController {

    @IBOutlet weak var profilesCollectionView: UICollectionView!
    @IBOutlet weak var sortPickerView: UIPickerView!

    let profileViewModel = ProfileViewModel()
    let sortData: [String] = ["Age - Ascending","Age - Descending","Name - Ascending","Name - Descending"]
    let filterData: [String] = ["Female","Male","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLogin()
        profileViewModel.delegate = self
        
        sortPickerView.dataSource = self
        sortPickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.PRESENT_LOGIN_SEGUE:
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.delegate = self
            }
        case Constants.PRESENT_CREATE_PROFILE_SEGUE:
            if let createProfileViewController = segue.destination as? CreateProfileViewController {
                createProfileViewController.delegate = self
            }
        default:
            break
        }
        
    }

    private func presentLogin() {
        performSegue(withIdentifier: Constants.PRESENT_LOGIN_SEGUE, sender: self)
    }

}

extension ProfilesViewController : LoginViewDelegate {
    func loginDidSucceed() {
        
        dismiss(animated: true) {
        }
        
        profileViewModel.getProfiles()
    }
    
    func logingDidFail() {
        
    }
}

extension ProfilesViewController : ProfileViewModelDelegate {
    func profilesChanged() {
        profilesCollectionView.reloadData()
    }
}

extension ProfilesViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortData.count
    }
    
    
}

extension ProfilesViewController : UICollectionViewDelegate {
    
}

extension ProfilesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let profile = profileViewModel.profiles[indexPath.row]
        
        cell.nameLabel.text = profile.getFirstNameLastName()
        cell.ageLabel.text = String(profile.age)
        cell.hobbiesLabel.text = profile.hobbies.description
        
        switch profile.gender {
        case "female":
            cell.backgroundColor = Constants.PINK_COLOR
            break
        case "male":
            cell.backgroundColor = Constants.BLUE_COLOR
            break
        default:
            cell.backgroundColor = Constants.GREEN_COLOR
            break
        }
        
        return cell
    }
    
}

extension ProfilesViewController: CreateProfileViewControllerDelegate {
    func profileCreationCancelled() {
        
    }
    
    func profileCreated() {
        
    }
}
