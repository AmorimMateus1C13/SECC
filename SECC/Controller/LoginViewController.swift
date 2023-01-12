//
//  ViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        loginView.emailTxt.delegate = self
        loginView.passwordTxt.delegate = self
        addInView()
        makeContrants()
    }
    
}

// MARK: - Contrants
 
extension LoginViewController {
    
    func addInView() {
        view.addSubview(loginView)
    }
    
    func makeContrants() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - TextField Configuration

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView.emailTxt.resignFirstResponder()
        loginView.passwordTxt.resignFirstResponder()
    }
}

extension LoginViewController: ButtonsOfLogin {
    func loginButton() {
        
        let tabBar = UITabBarController()
        
        let home = UINavigationController(rootViewController: HomeViewController())
        home.title = TitlesOfControllers.tabTitles.homeTitle
        
        let personalInfo = UINavigationController(rootViewController: PersonalInfoViewController())
        personalInfo.title = TitlesOfControllers.tabTitles.personalTitle
        
        let addPlus = UINavigationController(rootViewController: AddViewController())
        
        
        let shoppingCarts = UINavigationController(rootViewController: ShoppingCartsViewController())
        shoppingCarts.title = TitlesOfControllers.tabTitles.shoppingTitle
        
        let configView =  UINavigationController(rootViewController: ConfigViewController())
        configView.title = TitlesOfControllers.tabTitles.configTitle
        
        tabBar.setViewControllers([home, shoppingCarts, addPlus , personalInfo, configView], animated: true)
        
        tabBar.tabBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        guard let item = tabBar.tabBar.items else {
            return
        }
        
        let image = ["house", "cart", "plus" ,"person", "gearshape"]
        
        for x in 0..<item.count {
            item[x].image = UIImage(systemName: image[x])
        }
        
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar,animated: true)
    }
    
    func forgotButton() {
        let vc = ForgetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func creatButton() {
        let vc = CreatLoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
