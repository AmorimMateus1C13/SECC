//
//  PersonalInfoViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    var personalnfoView = PersonalInfoView()
    var userIdentifier: String = String()
    var userEmail: String = String()
    var userPassword: String = String()
    var userBlock: String = String()
    var userApt: String =  String()
    var userName: String = String()
    var userSurName: String = String()
    var personalViewModel: PersonalViewModel?
    
    init(userIdentifier: String, personalViewModel: PersonalViewModel? = PersonalViewModel()) {
        self.userIdentifier = userIdentifier
        self.personalViewModel = personalViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        personalViewModel?.delegate = self
        personalViewModel?.loadUserInformation(userIdentifier: userIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
        updateUserInfo()
    }
    
    func updateUserInfo() {
        if userName != String() && userEmail != String() && userPassword != String() && userBlock != String() && userApt != String() && userSurName != String() {
            personalnfoView.setUserInformation(
                email: userEmail,
                name: userName,
                surname: userSurName,
                password: userPassword,
                block: userBlock,
                apart: userApt)
        }
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

extension PersonalInfoViewController: PersonalViewModelProtocol {
    func getUserEmail(userEmail: String) {
        self.userEmail = userEmail
        viewDidLoad()
    }
    
    func getUserPassword(userPassword: String) {
        self.userPassword = userPassword
        viewDidLoad()
    }
    
    func getUserApart(userApartment: String) {
        self.userApt = userApartment
        viewDidLoad()
    }
    
    func getUserBlock(userBlock: String) {
        self.userBlock = userBlock
        viewDidLoad()
    }
    
    func getUserName(userName: String) {
        self.userName = userName
        viewDidLoad()
    }
    
    func getUserSurName(userSurName: String) {
        self.userSurName = userSurName
        viewDidLoad()
    }
}
