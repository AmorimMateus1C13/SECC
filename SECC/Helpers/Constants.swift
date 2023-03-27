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

struct DataObject {
    static let rootCategory = "categorias"
    static let categoryImage = "categoryImage"
    static let categoryName = "categoryName"
    static let objectOfcategory = "objectOfCategory"
    static let objectArrayImages = "objectArrayImages"
    static let itemImage = "itemImage"
    static let objectDetails = "objectDetails"
    static let objectImage = "objectImage"
    static let objectName = "objectName"
    static let objectPrice = "objectPrice"
    
    static let rootShoppingCart = "shoppingCart"
    static let itemName = "itemName"
    static let itemPrice = "itemPrice"
    static let itemDetail = "itemDetail"
    static let itemImageArray = "itemImageArray"
    
}
