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

    var delegate: CreateProfileViewControllerDelegate?
    
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
}
