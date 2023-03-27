////
////  UsersMockProvider.swift
////  SECC
////
////  Created by Mateus Amorim on 13/03/23.
////
//
//import Foundation
//
//class UsersMockProvider {
//    
//    func getData(callback: @escaping (Result<CreatUsers, Error>) -> Void) {
//        guard let json = readLocalFile(forName: Constants.usersJSON.jsonFileName) else { return }
//        do {
//            let data = try JSONDecoder().decode(CreatUsers.self, from: json)
//            callback(.success(data))
//        } catch let erro {
//            callback(.failure(erro))
//        }
//    }
//    
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundle = Bundle.main.path(forResource: name, ofType: Constants.usersJSON.typeJson),
//                let jsonData = try String(contentsOfFile: bundle).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//}
