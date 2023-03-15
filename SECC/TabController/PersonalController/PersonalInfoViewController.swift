//
//  PersonalInfoViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    var personalnfoView = PersonalInfoView()
    var currentUser: Users?
    
    init(currentUser: Users) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        personalnfoView.setUserInformation(
            email: currentUser?.email ?? String(),
            name: currentUser?.userName ?? String(),
            surname: currentUser?.userSurname ?? String(),
            password: currentUser?.password ?? String(),
            block: currentUser?.blockAdress ?? String(),
            apart: currentUser?.apartAdress ?? String())
    }

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
