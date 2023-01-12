//
//  PersonalInfoView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import Foundation
import SnapKit

class PersonalInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PersonalInfoView: ConfigurationView {
    func viewHierarchy() {
        
    }
    
    func setConstrants() {
        
    }
    
    
}
