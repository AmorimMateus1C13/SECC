//
//  CreatCategory.swift
//  SECC
//
//  Created by Mateus Amorim on 07/03/23.
//

import UIKit

struct CreatCategory: Codable {
    var categorias: [Category]
    
    enum CodingKeys: String, CodingKey {
        case categorias = "categorias"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categorias = try container.decode([Category].self, forKey: .categorias)
    }
}

struct Category: Codable {
    let categoryName: String
    var objectOfCategory: [ObjectOfCategory]
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "categoryName"
        case objectOfCategory = "objectOfCategory"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categoryName = try container.decode(String.self, forKey: .categoryName)
        self.objectOfCategory = try container.decode([ObjectOfCategory].self, forKey: .objectOfCategory)
    }
}

struct ObjectOfCategory: Codable {
    let objectName: String
    let objectPrice: String
    let objectDetails: String
    let objectImage: String
    let objectArrayImages: [ObjectArrayImages]
    
    enum CodingKeys: String, CodingKey {
        case objectName = "objectName"
        case objectPrice = "objectPrice"
        case objectDetails = "objectDetails"
        case objectImage = "objectImage"
        case objectArrayImages = "objectArrayImages"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.objectName = try container.decode(String.self, forKey: .objectName)
        self.objectPrice = try container.decode(String.self, forKey: .objectPrice)
        self.objectDetails = try container.decode(String.self, forKey: .objectDetails)
        self.objectImage = try container.decode(String.self, forKey: .objectImage)
        self.objectArrayImages = try container.decode([ObjectArrayImages].self, forKey: .objectArrayImages)
    }
}

struct ObjectArrayImages: Codable {
    let itemImage: String
    
    enum CodingKeys: String, CodingKey {
        case itemImage = "itemImage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.itemImage = try container.decode(String.self, forKey: .itemImage)
    }
}
