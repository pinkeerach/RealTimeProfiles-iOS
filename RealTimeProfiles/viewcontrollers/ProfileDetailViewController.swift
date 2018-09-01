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

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
