//
//  LoginViewModel.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/26/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelDelegate {
    func authenticationReturned(withUser: AuthDataResult?, error: Error?)
}

class LoginViewModel {
    
    var delegate : LoginViewModelDelegate?
    
    func authenticate(withUsername username: String, password: String) {
        
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            
            if let del = self.delegate {
                del.authenticationReturned(withUser: user, error: error)
            }
        }
    }
}
