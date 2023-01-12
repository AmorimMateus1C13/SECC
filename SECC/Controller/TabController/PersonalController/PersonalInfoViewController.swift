//
//  PersonalInfoViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    var personalnfoView = PersonalInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
    }
}

extension PersonalInfoViewController {
    
    func addInView() {
        view.addSubview(personalnfoView)
    }
    
    func makeConstrants() {
        personalnfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
