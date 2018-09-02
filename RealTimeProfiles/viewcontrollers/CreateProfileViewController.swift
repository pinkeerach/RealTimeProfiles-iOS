//
//  CreateProfileViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/26/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit


class CreateProfileViewController: UIViewController {

    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var profileImageUrlTextfield: UITextField!
    @IBOutlet weak var hobbiesTextfield: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    let profileViewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelProfileCreation() {
        
        self.dismiss(animated: true) {}
    }
    
    @IBAction func submitNewProfile() {
        
        if let firstname = firstNameTextfield.text,
            let lastname = lastNameTextfield.text,
            let profileimage = profileImageUrlTextfield.text,
            let gender = genderTextfield.text,
            let hobbies = hobbiesTextfield.text,
            let ageString = ageTextField.text,
            let age = Int(ageString) {
            
            let profile = Profile(identifier: nil, firstName: firstname, lastName: lastname, profilePicture: profileimage, age: age, hobbies: hobbies, gender: gender)
            
            profileViewModel.createProfile(profile)

            self.dismiss(animated: true) {}
        } else {
            let alert = UIAlertController(title: "Missing Data", message: "All fields are required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
