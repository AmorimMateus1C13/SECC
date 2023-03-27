////
////  MockProvider.swift
////  SECC
////
////  Created by Mateus Amorim on 08/03/23.
////
//
//import Foundation
//
//class CategoryMockProvider {
//    
//    func getData(callback: @escaping (Result<CreatCategory, Error>) -> Void) {
//        guard let json = readLocalFile(forName: Constants.infoFromJSON.jsonFileName) else { return }
//        do {
//            let data = try JSONDecoder().decode(CreatCategory.self, from: json)
//            callback(.success(data))
//        } catch let erro {
//            callback(.failure(erro))
//        }
//    }
//    
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundle = Bundle.main.path(forResource: name, ofType: Constants.infoFromJSON.typeJson),
//                let jsonData = try String(contentsOfFile: bundle).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//}
