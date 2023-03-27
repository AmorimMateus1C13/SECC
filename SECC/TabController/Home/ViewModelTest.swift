////
////  ViewModelTest.swift
////  SECC
////
////  Created by Mateus Amorim on 17/03/23.
////
//
//import Foundation
//import UIKit
//import FirebaseDatabase
//import Firebase
//
//protocol ViewModelProtocol {
//    func getAmountOfCategory(amountOfCategory: Int)
//    func getCategoriesNames(categoryNames: String)
//    func getCategoriesImages(categoryImage: String)
//}
//
//class HomeViewModel {
//    
//    var delegate: ViewModelProtocol?
//    let ref = Database.database().reference()
// 
//    func getAmountOfCategory() {
//        self.ref.child(DataObject.rootCategory).observe(.value) { DataSnapshot in
//            guard let categoryQtd = DataSnapshot.value as? [Any] else {
//                return
//            }
//            self.delegate?.getAmountOfCategory(amountOfCategory: categoryQtd.count)
//            self.getCategoriesNames(amountOfCategory: categoryQtd.count)
//            self.getCategoriesImages(amountOfCategory: categoryQtd.count)
//        }
//    }
//    
//    func getCategoriesNames(amountOfCategory: Int){
//        for i in 0..<amountOfCategory {
//            ref.child(DataObject.rootCategory).child("\(i)").child(DataObject.categoryName).observe(.value) { DataSnapshot in
//                guard let name = DataSnapshot.value as? String else { return }
//                self.delegate?.getCategoriesNames(categoryNames: name)
//            }
//        }
//    }
//    
//    func getCategoriesImages(amountOfCategory:Int) {
//        for i in 0..<amountOfCategory {
//            ref.child(DataObject.rootCategory).child("\(i)").child(DataObject.categoryImage).observe(.value) { DataSnapshot in
//                guard let image = DataSnapshot.value as? String else { return }
//                self.delegate?.getCategoriesImages(categoryImage: image)
//            }
//        }
//    }
//    
//    func getObjectName(category: Int) -> String {
//        var objectName: String = String()
//        ref.child(DataObject.rootCategory).child("\(category)").child(DataObject.objectName).observe(.value) { DataSnapshot in
//            guard let name = DataSnapshot.value as? String else { return }
//            objectName = name
//        }
//        return objectName
//    }
//}
