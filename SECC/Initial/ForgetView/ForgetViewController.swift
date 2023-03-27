//
//  ForgetViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit

class ForgetViewController: UIViewController {
    
    var forgetView = ForgetView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
    }
}

extension ForgetViewController {
    
    func addInView() {
        view.addSubview(forgetView)
    }
    
    func makeConstrants() {
        forgetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
