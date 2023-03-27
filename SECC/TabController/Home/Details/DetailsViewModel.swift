//
//  DetailsViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 21/03/23.
//

import UIKit
import FirebaseDatabase

protocol DetailsViewModelProtocol {
    func getObjectsImagesArray(objectimage: String)
    func getAmountOfImages(amountOfImages: Int)
    func getObjectDetail(detail: String)
}

class DetailsViewModel {
    var delegate: DetailsViewModelProtocol?
    var ref = Database.database().reference()
    
    func getAmountOfImages(categoryId: Int, objectId: Int) {
        self.ref.child(DataObject.rootCategory).child("\(categoryId)").child(DataObject.objectOfcategory).child("\(objectId)").child(DataObject.objectArrayImages).observe(.value) { DataSnapshot in
            guard let imageArray = DataSnapshot.value as? [Any] else { return }
            self.delegate?.getAmountOfImages(amountOfImages: imageArray.count)
            self.getObjectImages(categoryId: categoryId, objectId: objectId, amountOfImages: imageArray.count)
            self.getObjectDetail(categoryId: categoryId, objectId: objectId)
        }
    }
    
        func getObjectImages(categoryId: Int, objectId: Int, amountOfImages: Int) {
            for i in 0..<amountOfImages {
                self.ref.child(DataObject.rootCategory).child("\(categoryId)").child(DataObject.objectOfcategory).child("\(objectId)").child(DataObject.objectArrayImages).child("\(i)").child(DataObject.itemImage).observe(.value) { DataSnapshot in
                    guard let image = DataSnapshot.value as? String else { return }
                    self.delegate?.getObjectsImagesArray(objectimage: image)
                }
            }
    }
    
    func getObjectDetail(categoryId: Int, objectId: Int) {
        self.ref.child(DataObject.rootCategory).child("\(categoryId)").child(DataObject.objectOfcategory).child("\(objectId)").child(DataObject.objectDetails).observe(.value) { DataSnapshot in
                guard let detail = DataSnapshot.value as? String else { return }
                self.delegate?.getObjectDetail(detail: detail)
            }
    }
}
