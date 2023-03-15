//
//  Constants.swift
//  SECC
//
//  Created by Mateus Amorim on 08/03/23.
//

import Foundation

struct Constants {
    static let usersJSON = UsersJson.self
    static let infoFromJSON = InfoFromJSON.self
}

struct UsersJson {
    static let jsonFileName = "UsersJSON"
    static let typeJson = "json"
    static let defaultName = "Users_default"
}

struct InfoFromJSON {
    static let jsonFileName = "InfoFromJSON"
    static let typeJson = "json"
    static let defaultName = "default"
}
