//
//  ShoppingCartsViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit
import SwipeCellKit

class ShoppingCartsViewController: UIViewController {
    
    var shopEmptyView = ShopEmptyView()
    var shopCollectionView = ShopCollectionView()
    
    var indexPathDelete = IndexPath()
    var objectOfCategory: ObjectOfCategory?
    var itemName: String = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shopCollectionView.collectionView.reloadData()
        addInView()
        makeConstrants()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        shopCollectionView.collectionView.delegate = self
        shopCollectionView.collectionView.dataSource = self
    }
}

extension ShoppingCartsViewController {
    
    func addInView() {
        if ShoppingItemsCart.itemsTitle.count == 0 {
            view.addSubview(shopEmptyView)
        }else {
            shopEmptyView.removeFromSuperview()
            view.addSubview(shopCollectionView)
        }
    }
    
    func makeConstrants() {
        if ShoppingItemsCart.itemsTitle.count == 0 {
            shopEmptyView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            shopCollectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
        }
    }
}

extension ShoppingCartsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ShoppingItemsCart.itemsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        indexPathDelete = indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCell.identifier, for: indexPath) as? ShoppingCell
        
        cell?.configCell(titleOfCell: ShoppingItemsCart.itemsTitle[indexPath.row], imageOfCell: ShoppingItemsCart.imagesItems[indexPath.row], productOfValue: ShoppingItemsCart.valuesItems[indexPath.row])
        cell?.delegate = self
        cell?.buttonDelete.tag = indexPath.row
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemSafe = objectOfCategory else { return}
        let vc = DetailsItemViewController(objectOfCategory: itemSafe, backButtonTitle: "Voltar")
            navigationController?.pushViewController(vc, animated: true)
    }
}

extension ShoppingCartsViewController: DeleteButtonAction {

    func deleteAction(currentTag: Int) {
        print(ShoppingItemsCart.itemsTitle[currentTag])
        
        ShoppingItemsCart.itemsTitle.remove(at: currentTag)
        ShoppingItemsCart.imagesItems.remove(at: currentTag)
        ShoppingItemsCart.detailItems.remove(at: currentTag)
        ShoppingItemsCart.valuesItems.remove(at: currentTag)
        shopCollectionView.collectionView.reloadData()
        viewWillAppear(true)
    }
}
