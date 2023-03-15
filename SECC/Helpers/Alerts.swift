//
//  Alerts.swift
//  SECC
//
//  Created by Mateus Amorim on 08/03/23.
//

import UIKit

class Alerts {
    static func creatAlertCustom(title: String, message: String, buttonMessage: String? = "OK", view: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonMessage, style: .cancel))
        view.present(ac,animated: true)
    }
}
