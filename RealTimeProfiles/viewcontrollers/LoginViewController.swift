//
//  LoginViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/20/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol LoginViewDelegate {
    func loginDidSucceed()
    func logingDidFail()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginbutton: UIButton!
    
    var delegate : LoginViewDelegate?
    let loginViewModel : LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel.delegate = self
        
        toggleActivity(isOn: false) //because activity indicators are pesky
        
        usernameTextfield.becomeFirstResponder()
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
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        
        toggleActivity(isOn: true)
        
        guard let username = usernameTextfield.text,
            let password = passwordTextfield.text,
            usernameTextfield.text != "",
            passwordTextfield.text != "" else {
            
                errorLabel.isHidden = false
                errorLabel.text = "Username & password cannot be blank"
                
                toggleActivity(isOn: false)
                return
        }
        
        errorLabel.isHidden = true
        
        loginViewModel.authenticate(withUsername: username, password: password)
        
    }
    
    private func handleAuthenticationComplete(withUser: AuthDataResult?, error: Error?) {
        if let _ = error {
            
            self.errorLabel.isHidden = false
            self.errorLabel.text = "Invalid credentials"
            self.toggleActivity(isOn: false)
            return
        }
        
        if let del = self.delegate {
            del.loginDidSucceed()
            self.toggleActivity(isOn: false)
        }
    }
    
    private func toggleActivity(isOn: Bool) {
        if isOn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        loginbutton.isHidden = isOn
        activityIndicator.isHidden = !isOn
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func authenticationReturned(withUser: AuthDataResult?, error: Error?) {
        handleAuthenticationComplete(withUser: withUser, error: error)
    }
}
