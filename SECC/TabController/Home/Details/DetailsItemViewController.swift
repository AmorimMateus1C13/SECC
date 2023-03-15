//
//  DetailsItemViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit

class DetailsItemViewController: UIViewController {
        
    var objectOfCategory: ObjectOfCategory?
    var detailsView = DetailsView()
    var backButtonTitle: String = String()
 
    init(objectOfCategory: ObjectOfCategory, backButtonTitle: String = String()) {
        super.init(nibName: nil, bundle: nil)
        self.objectOfCategory = objectOfCategory
        self.backButtonTitle = backButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        detailsView.delegate = self
        setViewinformations()
        navigationController?.navigationBar.topItem?.backButtonTitle = backButtonTitle
    }
}

extension DetailsItemViewController: ConfigurationView {
    
    func viewHierarchy() {
        view.addSubview(detailsView)
    }
    
    func setConstrants() {
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setViewinformations() {
        detailsView.setView(
            itemsCollectionImages: self.objectOfCategory?.objectArrayImages ?? [ObjectArrayImages](),
            valueItem: self.objectOfCategory?.objectPrice ?? String(),
            detail: self.objectOfCategory?.objectDetails ?? String(),
            title: self.objectOfCategory?.objectName ?? String())
    }
}

extension DetailsItemViewController: ButtonsActions {
    
    func addInCart() {
        guard let objectSafe = objectOfCategory else { return}
        
        if ShoppingItemsCart.itemsTitle.contains(objectSafe.objectName) {
            Alerts.creatAlertCustom(title: "Atenção", message: "Esse item já foi adicionado ao carrinho.", view: self)
        } else {
            ShoppingItemsCart.itemsTitle.append(objectSafe.objectName)
            ShoppingItemsCart.imagesItems.append(objectSafe.objectImage)
            ShoppingItemsCart.detailItems.append(objectSafe.objectDetails)
            ShoppingItemsCart.valuesItems.append(objectSafe.objectPrice)
        }
    }
    
    
    func buyItem() {
        let vc = BuyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
