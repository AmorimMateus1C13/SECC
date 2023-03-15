//
//  ExtensionImageView.swift
//  SECC
//
//  Created by Mateus Amorim on 09/03/23.
//

import UIKit

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
      if let url = URL(string: URLAddress) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
