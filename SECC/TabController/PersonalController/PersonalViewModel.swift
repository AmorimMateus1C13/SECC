//
//  PersonalViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 24/03/23.
//

import UIKit
import FirebaseDatabase

protocol PersonalViewModelProtocol {
    func getUserEmail(userEmail: String)
    func getUserPassword(userPassword: String)
    func getUserApart(userApartment: String)
    func getUserBlock(userBlock: String)
    func getUserName(userName: String)
    func getUserSurName(userSurName: String)
}

class PersonalViewModel {
    let ref = Database.database().reference()
    
    var delegate: PersonalViewModelProtocol?
    
    func loadUserInformation(userIdentifier: String) {
        getUserEmail(userIdentifier: userIdentifier)
        getUserPassword(userIdentifier: userIdentifier)
        getUserApart(userIdentifier: userIdentifier)
        getUserBlock(userIdentifier: userIdentifier)
        getUserName(userIdentifier: userIdentifier)
        getUserSurName(userIdentifier: userIdentifier)
    }
    
    func getUserEmail(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("email").observeSingleEvent(of: .value) { DataSnapshot in
            guard let email = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserEmail(userEmail: email)
        }
    }
    
    func getUserPassword(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("password").observeSingleEvent(of: .value) { DataSnapshot in
            guard let password = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserPassword(userPassword: password)
        }
    }
    
    func getUserApart(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("userApart").observeSingleEvent(of: .value) { DataSnapshot in
            guard let apartment = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserApart(userApartment: apartment)
        }
    }
    
    func getUserBlock(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("userBlock").observeSingleEvent(of: .value) { DataSnapshot in
            guard let block = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserBlock(userBlock: block)
        }
    }
    
    func getUserName(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("userName").observeSingleEvent(of: .value) { DataSnapshot in
            guard let name = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserName(userName: name)
        }
    }
    
    func getUserSurName(userIdentifier: String) {
        ref.child("Users").child(userIdentifier).child("userId").child("userSurName").observeSingleEvent(of: .value) { DataSnapshot in
            guard let surName = DataSnapshot.value as? String else {
                print("caminho errado")
                return }
            self.delegate?.getUserSurName(userSurName: surName)
        }
    }
}
