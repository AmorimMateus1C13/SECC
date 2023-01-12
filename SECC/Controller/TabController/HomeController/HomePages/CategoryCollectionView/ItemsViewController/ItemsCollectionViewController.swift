//
//  ItemsCollectionViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit

class ItemsCollectionViewController: UIViewController {
    
    var items: [String] = []
    var imagesItems2: [UIImage] = []
    var value: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        navigationController?.navigationBar.topItem?.backButtonTitle = TitlesOfControllers.tabTitles.homeTitle
        addInView()
        makeConstrants()
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2) - 16, height: (view.frame.size.width/2) - 4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 16
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
}

extension ItemsCollectionViewController {
    
    func addInView() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    func makeConstrants() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
}

extension ItemsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as? ItemsCollectionViewCell
        
        cell?.changeImage(image: imagesItems2[indexPath.row], title: items[indexPath.row], value: value[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let titleBack = titleLabel.text else { return }
        let vc = DetailsItemViewController(titleOfItem: items[indexPath.row], imageOfItem: imagesItems2[indexPath.row], detailOfItem: ItemsMock.itemsCollection.productDetail[0], valueOfItem: value[indexPath.row], titleLabel: titleBack)
        
            navigationController?.pushViewController(vc, animated: true)
    }
}
