//
//  ProfileDetailViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 9/1/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var hobbiesTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let profileViewModel = ProfileViewModel()
    var selectedProfile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let profile = selectedProfile {
            firstNameTextField.text = profile.firstName
            lastNameTextField.text = profile.lastName
            genderTextField.text = profile.gender
            hobbiesTextField.text = profile.hobbies
            
            if let profileImage = profileViewModel.loadImage(fromUrl: profile.profilePicture) {
                imageView.image = profileImage
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonTapped() {
        if let profile = selectedProfile,
            let hobbies = hobbiesTextField.text {
            
            var newProfile = profile
            newProfile.hobbies = hobbies
            
            profileViewModel.updateProfile(newProfile)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonTapped() {
        let alert = UIAlertController(title: "Delete Confirmation", message: "This is a destructive action. There is no undo. Are you sure you want to delete this record?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "I'm Sure!", style: .default, handler: { (action) in
            
            if let profile = self.selectedProfile {
                self.profileViewModel.deleteProfile(profile)
                self.navigationController?.popViewController(animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
