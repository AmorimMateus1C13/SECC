////
////  GetLocalJson.swift
////  SECC
////
////  Created by Mateus Amorim on 08/03/23.
////
//
//import Foundation
//
//class GetLocalJson {
//    static func getLocal()-> CreatCategory? {
//        if let data = UserDefaults.standard.data(forKey: Constants.infoFromJSON.defaultName) {
//            do {
//                let decoder = JSONDecoder()
//                return try decoder.decode(CreatCategory.self, from: data)
//            }catch {
//                print("Unable to decode Note \(error)")
//            }
//        }
//        return nil
//    }
//}
