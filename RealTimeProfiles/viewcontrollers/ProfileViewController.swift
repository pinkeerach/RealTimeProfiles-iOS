//
//  ViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/15/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController {

    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if true {
            presentLogin()
        }
        
        profileViewModel.fetchProfiles()
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
    }
    
    func logingDidFail() {
        
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
        
        return cell
    }
    
    
}
