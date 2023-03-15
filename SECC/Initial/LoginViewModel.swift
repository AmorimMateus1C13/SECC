//
//  LoginViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 07/03/23.
//

import UIKit
protocol LoginViewModelProtocol {
    func showAlert()
}
class LoginViewModel {
    
    var delegate: LoginViewModelProtocol?
    var user: [Users]?
    var provider: UsersMockProvider
    
    init(delegate: LoginViewModelProtocol? = nil, user: [Users]? = nil, provider: UsersMockProvider = UsersMockProvider()) {
        self.delegate = delegate
        self.user = user
        self.provider = provider
    }
    
    func callMock() {
        if let user = getLocal() {
            self.user = user.users
        } else {
            self.provider.getData { result in
                switch result {
                case .success(let response):
                    self.user = response.users
                case .failure(_):
                    self.delegate?.showAlert()
                }
            }
        }
    }
    
   func getLocal()-> CreatUsers? {
        if let data = UserDefaults.standard.data(forKey: Constants.usersJSON.defaultName) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(CreatUsers.self, from: data)
            }catch {
                print("Unable to decode Note \(error)")
            }
        }
        return nil
    }
}
