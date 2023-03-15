//
//  CreatLoginViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit

class CreatLoginViewController: UIViewController {
    
    var creatLoginView = CreatLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
        creatLoginView.delegate = self
        creatLoginView.emailText.delegate = self
        creatLoginView.passwordText.delegate = self
        navigationController?.isNavigationBarHidden = false
    }
}


//MARK: - Add In View
extension CreatLoginViewController {
    
    func addInView() {
        view.addSubview(creatLoginView)
    }
    
    func makeConstrants() {
        creatLoginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CreatLoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        creatLoginView.emailText.resignFirstResponder()
        creatLoginView.passwordText.resignFirstResponder()
    }
}
extension CreatLoginViewController: CreatLoginViewButtons {
    func creatButton() {
        print("Works!")
    }
}
