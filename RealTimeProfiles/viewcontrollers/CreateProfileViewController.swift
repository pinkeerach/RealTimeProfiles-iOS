//
//  CreateProfileViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/26/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

protocol CreateProfileViewControllerDelegate {
    func profileCreated()
    func profileCreationCancelled()
}

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var profileImageUrlTextfield: UITextField!
    @IBOutlet weak var hobbiesTextfield: UITextField!
    
    var delegate: CreateProfileViewControllerDelegate?
    
    let profileViewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelProfileCreation() {

        self.dismiss(animated: true) {}
        
//        if let del = delegate {
//            del.profileCreationCancelled()
//        }
    }
    
    @IBAction func submitNewProfile() {
        
        if let firstname = firstNameTextfield.text,
            let lastname = lastNameTextfield.text,
            let profileimage = profileImageUrlTextfield.text,
            let gender = genderTextfield.text,
            let hobbies = hobbiesTextfield.text {
            
            let profile = Profile(identifier: nil, firstName: firstname, lastName: lastname, profilePicture: profileimage, age: 12, hobbies: hobbies, gender: gender)
            
            profileViewModel.createProfile(withProfile: profile)

            self.dismiss(animated: true) {}
        }
        
    }
}
