//
//  ConfigurationVIew.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import Foundation

protocol ConfigurationView {
    func setupConfiguration()
    func viewHierarchy()
    func setConstrants()
}

extension ConfigurationView {
    func setupConfiguration() {
        viewHierarchy()
        setConstrants()
    }
}
