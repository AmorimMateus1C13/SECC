//
//  ConfigViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit

class ConfigViewController: UIViewController {
    
    var configView = ConfigView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutPressed))
    }
}

extension ConfigViewController {
    
    func addInView(){
        view.addSubview(configView)
    }
    
    func makeConstrants() {
        configView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func logOutPressed() {
        self.dismiss(animated: true)
    }
}
