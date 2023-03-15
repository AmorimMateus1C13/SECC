//
//  HomeViewModel.swift
//  SECC
//
//  Created by Mateus Amorim on 08/03/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func showAlert()
}

class HomeViewModel {
    
    var delegate: HomeViewModelProtocol?
    var category: [Category]?
    var provider: CategoryMockProvider
    
    init(delegate: HomeViewModelProtocol? = nil, category: [Category]? = nil, provider: CategoryMockProvider = CategoryMockProvider()) {
        self.delegate = delegate
        self.category = category
        self.provider = provider
    }
    
    func callMock() {
        if let categoryData = GetLocalJson.getLocal() {
            self.category = categoryData.categorias
        } else {
            self.provider.getData { result in
                switch result {
                case .success(let response):
                    self.category = response.categorias
                case .failure(_):
                    self.delegate?.showAlert()
                }
            }
        }
    }
    
}
