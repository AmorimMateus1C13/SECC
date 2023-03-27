//
//  HomeViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit
import FirebaseDatabase
import Firebase

class HomeViewController: UIViewController {
    
    var amountOfCategory: Int = Int()
    var namesOfCategories: [String] = []
    var categoriesImages: [String] = []
    var userIndentifier: String = String()
    var viewModelTest: HomeViewModel?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2) - 4, height: (view.frame.size.width/2) - 4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    init(viewModelTest: HomeViewModel = HomeViewModel(), userIndentifier: String) {
        self.viewModelTest = viewModelTest
        self.userIndentifier = userIndentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        addInView()
        makeConstrants()
        viewModelTest?.getAmountOfCategory()
        viewModelTest?.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - Add In View
extension HomeViewController {
    
    func addInView() {
        view.addSubview(collectionView)
    }
    
    func makeConstrants() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func noItemsFind(item: [String]) {
        if item.count == 0 {
            let ac = UIAlertController(title: "", message: "Não há itens disponiveis para essa categoria no momento.", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Retornar", style: .cancel)
            ac.addAction(alert)
            present(ac, animated: true)
        }
    }
}


extension HomeViewController: ViewModelProtocol {
    
    func getCategoriesImages(categoryImage: String) {
        self.categoriesImages.append(categoryImage)
        collectionView.reloadData()
    }
    
    func getCategoriesNames(categoryNames: String) {
        self.namesOfCategories.append(categoryNames)
        collectionView.reloadData()
    }
    
    func getAmountOfCategory(amountOfCategory: Int) {
        self.amountOfCategory = amountOfCategory
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amountOfCategory
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell
        
        if namesOfCategories != [] && categoriesImages != [] {
            cell?.choiceTitle(title: namesOfCategories[indexPath.row])
            cell?.choiceImageButton(image: categoriesImages[indexPath.row])
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemsCollectionViewController(categoryTitle: namesOfCategories[indexPath.row], categoryId: indexPath.row, userIndentifier: userIndentifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}
