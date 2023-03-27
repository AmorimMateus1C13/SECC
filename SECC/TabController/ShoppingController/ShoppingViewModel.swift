//
//  ShoppingViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 13/03/23.
//

import UIKit
import FirebaseDatabase

protocol ShoppingViewModelProtocol {
    func getAmountOfSHoppingItems(items: Int)
    func getItemName(itemName: String)
    func getItemImage(itemImage: String)
    func getItemPrice(itemPrice: String)
    func getCategoryName(currentCategory: String)
    func getCategoryId(currentId: Int)
    func callViewEmpty()
    func addCollectionViewInView()
}
class ShoppingViewModel {
    var delegate: ShoppingViewModelProtocol?
    let ref = Database.database().reference()
    
    func getShoppingCartData(userIndentifier: String) {
        self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).observe(.value) { DataSnapshot in
            guard let array = DataSnapshot.value as? [Any] else { return }
            if array.count > 1 {
                self.delegate?.getAmountOfSHoppingItems(items: array.count)
                self.getItemName(userIndentifier: userIndentifier, itemId: array.count)
                self.getItemImage(userIndentifier: userIndentifier, itemId: array.count)
                self.getItemPrice(userIndentifier: userIndentifier, itemId: array.count)
                self.getCurrentCategory(userIndentifier: userIndentifier, itemId: array.count)
                self.getCategoryId(userIndentifier: userIndentifier, itemId: array.count)
            }else {
                self.isEmpty(userIndentifier: userIndentifier, itemId: array.count)
            }
        }
    }
    
    func getCurrentCategory(userIndentifier: String, itemId: Int) {
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child("categoryName").observe(.value) { DataSnapshot in
                guard let name = DataSnapshot.value as? String else { return }
                self.delegate?.getCategoryName(currentCategory: name)
            }
        }
    }
    
    func getCategoryId(userIndentifier: String, itemId: Int){
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child("categoryId").observe(.value) { DataSnapshot in
                guard let id = DataSnapshot.value as? String else { return }
                
                self.delegate?.getCategoryId(currentId: Int(id) ?? 0)
            }
        }
    }
    
    func getItemName(userIndentifier: String, itemId: Int) {
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child(DataObject.itemName).observe(.value) { DataSnapshot in
                guard let name = DataSnapshot.value as? String else { return }
                self.delegate?.getItemName(itemName: name)
            }
        }
    }
    
    func getItemImage(userIndentifier: String, itemId: Int) {
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child(DataObject.itemImage).observe(.value) { DataSnapshot in
                guard let image = DataSnapshot.value as? String else {
                    return }
                self.delegate?.getItemImage(itemImage: image)
            }
        }
    }
    
    func getItemPrice(userIndentifier: String, itemId: Int) {
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child(DataObject.itemPrice).observe(.value) { DataSnapshot in
                guard let price = DataSnapshot.value as? String else {
                    return }
                self.delegate?.getItemPrice(itemPrice: price)
            }
        }
    }
    
    func isEmpty(userIndentifier: String, itemId: Int) {
        for i in 0..<itemId {
            self.ref.child("Users").child(userIndentifier).child(DataObject.rootShoppingCart).child("\(i)").child(DataObject.itemName).observe(.value) { DataSnapshot in
                guard let name = DataSnapshot.value as? String else {
                    return }
                if name.isEmpty {
                    self.delegate?.callViewEmpty()
                } else {
                    self.getItemName(userIndentifier: userIndentifier, itemId: itemId)
                    self.getItemImage(userIndentifier: userIndentifier, itemId: itemId)
                    self.getItemPrice(userIndentifier: userIndentifier, itemId: itemId)
                    self.delegate?.addCollectionViewInView()
                }
            }
        }
    }
    
    func deleteItem(userIdentifier: String, itemTag: Int, itemNameArray: [String], itemImageArray: [String], itemPriceArray: [String]) {
        
        self.ref.child("Users").child(userIdentifier).child(DataObject.rootShoppingCart).observeSingleEvent(of: .value) { DataSnapshot in
            guard let name = DataSnapshot.value as? [Any] else { return }
            if name.count == 1 {
                self.ref.child("Users").child(userIdentifier).child(DataObject.rootShoppingCart).child("\(itemTag)").removeValue()
                
                let itemCart: [String: Any] = [
                    "itemName": "" as NSObject,
                    "itemPrice": "",
                    "itemDetail": "",
                    "itemImage": ""
                ]

                self.ref.child("Users").child("\(userIdentifier)").child(DataObject.rootShoppingCart).child("0").setValue(itemCart)
            } else if (name.count - 1) > itemTag {
                let nextItem = itemTag + 1
                for i in nextItem..<name.count {
                    let itemCart: [String: Any] = [
                        "itemName": "\(itemNameArray[i])" as NSObject,
                        "itemPrice": "\(itemPriceArray[i])",
                        "itemImage": "\(itemImageArray[i])"
                    ]

                    self.ref.child("Users").child("\(userIdentifier)").child(DataObject.rootShoppingCart).child("\(i - 1)").setValue(itemCart)
                }
                self.ref.child("Users").child(userIdentifier).child(DataObject.rootShoppingCart).child("\(name.count - 1)").removeValue()
            } else {
                self.ref.child("Users").child(userIdentifier).child(DataObject.rootShoppingCart).child("\(itemTag)").removeValue()
            }
        }
    }
}
