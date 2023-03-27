//
//  ItemsViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 20/03/23.
//

import UIKit
import FirebaseDatabase

protocol ItemsViewModelProtocol {
    func getAmountObjects(amountOfObjects: Int)
    func getObjectImages(objectImages: String)
    func getObjectName(objectName: String)
    func getObjectPrice(objectPrice: String)
}

class ItemsViewModel {
    
    var ref = Database.database().reference()
    var delegate: ItemsViewModelProtocol?
    
    func getAmountOfObjects(category: Int) {
        ref.child(DataObject.rootCategory).child("\(category)").child(DataObject.objectOfcategory).observe(.value) { DataSnapshot in
            guard let objectArray = DataSnapshot.value as? [Any] else {
                return
            }
            self.delegate?.getAmountObjects(amountOfObjects: objectArray.count)
            self.getObjectsImages(categoyId: category, objectIds: objectArray.count)
            self.getObjectsNames(categoyId: category, objectIds: objectArray.count)
            self.getObejctsPrices(categoyId: category, objectIds: objectArray.count)
        }
    }
    
    func getObjectsImages(categoyId: Int, objectIds: Int) {
        for i in 0..<objectIds {
            self.ref.child(DataObject.rootCategory).child("\(categoyId)").child(DataObject.objectOfcategory).child("\(i)").child(DataObject.objectImage).observe(.value) { DataSnapshot in
                guard let objectImage = DataSnapshot.value as? String else {return}
                self.delegate?.getObjectImages(objectImages: objectImage)
            }
        }
    }
    
    func getObjectsNames(categoyId: Int, objectIds: Int) {
        for i in 0..<objectIds {
            self.ref.child(DataObject.rootCategory).child("\(categoyId)").child(DataObject.objectOfcategory).child("\(i)").child(DataObject.objectName).observe(.value) { DataSnapshot in
                guard let objectName = DataSnapshot.value as? String else {return}
                self.delegate?.getObjectName(objectName: objectName)
            }
        }
    }
    
    func getObejctsPrices(categoyId: Int, objectIds: Int) {
        for i in 0..<objectIds {
            self.ref.child(DataObject.rootCategory).child("\(categoyId)").child(DataObject.objectOfcategory).child("\(i)").child(DataObject.objectPrice).observe(.value) { DataSnapshot in
                guard let objectPrice = DataSnapshot.value as? String else {return}
                self.delegate?.getObjectPrice(objectPrice: objectPrice)
            }
        }
    }
}
