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
    var shoppingCarts = ShoppingCarts()
    
    var indexPathDelete = IndexPath()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        addInView()
        makeConstrants()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2 - 16), height: (view.frame.size.width/2 - 4))
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ShoppingCell.self, forCellWithReuseIdentifier: ShoppingCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    var labelAlert: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.italicSystemFont(ofSize: 21)
        label.text = "Nenhum item adicionado ao carrinho."
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 30
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
}

extension ShoppingCartsViewController {
    
    func addInView() {
        if ShoppingItemsCart.itemsTitle.count == 0 {
            view.addSubview(labelAlert)
        } else {
            labelAlert.removeFromSuperview()
            view.addSubview(collectionView)
        }
    }
    
    func makeConstrants() {
        if ShoppingItemsCart.itemsTitle.count == 0 {
            labelAlert.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.trailing.leading.equalToSuperview().inset(24)
            }
        }
        else {
            collectionView.snp.makeConstraints { make in
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
        let vc = DetailsItemViewController(titleOfItem: ShoppingItemsCart.itemsTitle[indexPath.row], imageOfItem: ShoppingItemsCart.imagesItems[indexPath.row], detailOfItem: ShoppingItemsCart.detailItems[indexPath.row], valueOfItem: ShoppingItemsCart.valuesItems[indexPath.row],titleLabel: TitlesOfControllers.tabTitles.shoppingTitle)
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
        collectionView.reloadData()
        viewWillAppear(true)
    }
}
