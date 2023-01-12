//
//  HomeViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var imagesForVoidItems: [UIImage] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2) - 4, height: (view.frame.size.width/2) - 4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        addInView()
        makeConstrants()
    }
    
    func itemsAreCorrect(items: Int, images: Int, mockImages: [UIImage]) {
        if imagesForVoidItems.count != items {
            if items == images {
                imagesForVoidItems = mockImages
            } else {
                for _ in 0..<items {
                    print(items)
                    if let gearImage = UIImage(systemName: "questionmark.folder.fill") {
                        imagesForVoidItems.append(gearImage)
                    }
                }
            }
        }
//        "questionmark.folder.fill"

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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemsMock.homeController.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        
        cell?.choiceImageButton(image: ItemsMock.homeController.images[indexPath.row])
        cell?.choiceTitle(title: ItemsMock.homeController.titles[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemsCollectionViewController()
        vc.titleLabel.text = ItemsMock.homeController.titles[indexPath.row]
        
        imagesForVoidItems = []
        switch indexPath.row {
            
        case 0:
            
            vc.items = ItemsMock.tools.toolTitle
            vc.imagesItems2 = ItemsMock.tools.itemImage
            vc.value = ItemsMock.tools.toolValues
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
           
            vc.items = ItemsMock.apt.aptTitle
            vc.value = ItemsMock.apt.aptValues
            
            itemsAreCorrect(items: vc.items.count, images: ItemsMock.apt.aptImage.count, mockImages: ItemsMock.apt.aptImage)
            
            vc.imagesItems2 = imagesForVoidItems
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            
            vc.items = ItemsMock.recreation.recreationTitle
//            vc.imagesItems = ItemsMock.recreation.recreationImage
            
            itemsAreCorrect(items: vc.items.count, images: ItemsMock.recreation.recreationImage.count, mockImages: ItemsMock.recreation.recreationImage)
            vc.imagesItems2 = imagesForVoidItems
            
            vc.value = ItemsMock.recreation.recreationValues
            
//            itemsAreCorrect(items: vc.items.count, images: ItemsMock.tools.itemImage.count, mockImages: ItemsMock.tools.itemImage)
//            vc.imagesItems2 = imagesForVoidItems
            
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            
            vc.items = ItemsMock.partyRoom.partyRoomTitle
//            vc.imagesItems = ItemsMock.partyRoom.partyRoomImage
            
            itemsAreCorrect(items: vc.items.count, images: ItemsMock.partyRoom.partyRoomImage.count, mockImages: ItemsMock.partyRoom.partyRoomImage)
            vc.imagesItems2 = imagesForVoidItems
            
//            vc.imagesItems2 = ItemsMock.tools.itemImage
            vc.value = ItemsMock.partyRoom.partyRoomValues
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            
            vc.items = ItemsMock.services.servicesTitle
//            vc.imagesItems = ItemsMock.services.servicesImage
            itemsAreCorrect(items: vc.items.count, images: ItemsMock.services.servicesImage.count, mockImages: ItemsMock.services.servicesImage)
            vc.imagesItems2 = imagesForVoidItems
            
//            vc.imagesItems2 = ItemsMock.tools.itemImage
            vc.value = ItemsMock.services.servicesValues
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            
            vc.items = ItemsMock.parking.parkingTitle
//            vc.imagesItems = ItemsMock.parking.parkingImage
            itemsAreCorrect(items: vc.items.count, images: ItemsMock.parking.parkingImage.count, mockImages: ItemsMock.parking.parkingImage)
            vc.imagesItems2 = imagesForVoidItems
            
//            vc.imagesItems2 = ItemsMock.tools.itemImage
            vc.value = ItemsMock.parking.parkingValues
            noItemsFind(item: vc.items)
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
