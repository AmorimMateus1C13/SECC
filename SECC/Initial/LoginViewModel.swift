//
//  LoginViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 07/03/23.
//

import UIKit
import FirebaseDatabase

protocol LoginViewModelProtocol {
    func callTabBarController(userIndentifier: String)
    func emailDontExist()
    func emailDifferenceInEmail()
}

class LoginViewModel {
    
    let ref = Database.database().reference()
    var delegate: LoginViewModelProtocol?
    
    func getUserFromFirebase(blockAndApat: String, userPassword: String) {
        ref.child("Users").child(blockAndApat).child("userId").child("password").observeSingleEvent(of: .value) { DataSnapshot in
            guard let usersArray = DataSnapshot.value as? String else {
                self.delegate?.emailDontExist()
                return
            }
            self.getPassword(passData: usersArray, userPassword: userPassword, userIdentifier: blockAndApat)
        }
    }
    
    func getPassword(passData: String, userPassword: String, userIdentifier: String) {
        if passData == userPassword {
            self.delegate?.callTabBarController(userIndentifier: userIdentifier)
        } else {
            self.alertDifferenceEmail()
        }
    }

    func alertDifferenceEmail() {
        self.delegate?.emailDifferenceInEmail()
    }
}
