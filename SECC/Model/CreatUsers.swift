//
//  CreatUsers.swift
//  SECC
//
//  Created by Mateus Amorim on 13/03/23.
//

import UIKit

struct CreatUsers: Codable{
    
    var users: [Users]
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.users = try container.decode([Users].self, forKey: .users)
    }
}

struct Users: Codable {
    let email : String
    let password: String
    let userName: String
    let userSurname: String
    let blockAdress: String
    let apartAdress: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case userName = "userName"
        case userSurname = "userSurname"
        case blockAdress = "blockAdress"
        case apartAdress = "apartAdress"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userSurname = try container.decode(String.self, forKey: .userSurname)
        self.blockAdress = try container.decode(String.self, forKey: .blockAdress)
        self.apartAdress = try container.decode(String.self, forKey: .apartAdress)
    }
}
