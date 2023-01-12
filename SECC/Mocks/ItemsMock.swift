//
//  ItemsMock.swift
//  SECC
//
//  Created by Mateus Amorim on 29/11/22.
//

import Foundation
import UIKit

struct ItemsMock {
    static let tools = Tools.self
    static let apt = Apt.self
    static let recreation = Recreation.self
    static let partyRoom =  PartyRoom.self
    static let services = Services.self
    static let parking = Parking.self
    static let category =  Category.self
    static let homeController = HomeController.self
    static let itemsCollection = ItemsCollectionController.self
}


struct HomeController {
    static var images: [String] = ["books.vertical", "building", "sportscourt", "checkerboard.rectangle", "creditcard","key"]
    
    static var titles: [String] = ["Ferramentas", "Apartamentos", "Recreação", "Salão de Festa", "Serviços", "Estacionamento"]
}

struct ItemsCollectionController {
    static var productDetail: [String] = ["Nenhuma descrição disponível."]
}

struct Category {
    static var titles: [String] = ["Ferramentas", "Apartamentos", "Recreação", "Salão de Festa", "Serviços", "Estacionamento"]
}

struct Tools {
    static var toolTitle: [String] = ["Martelo", "Chave Inglesa", "Multímetro"]
    
    static var toolImage: [String] = ["Martelo", "ChaveInglesa", "Multimetro"]
    
    static var itemImage: [UIImage] = [ImagesMock.marteloImage!, ImagesMock.chaveImage!, ImagesMock.medidorImage!]
    
    static var toolValues: [String] = ["R$5,00", "R$7,00", "R$15,00"]
    
    static let hammer: [String] = ["Martelo", "Martelo0", "Martelo1"]
    static let keyIngl: [String] = ["ChaveInglesa", "ChaveInglesa0", "ChaveInglesa1"]
    static let mult: [String] = ["Multimetro", "Multimetro0", "Multimetro1"]
    
}

struct Apt {
    static var aptTitle: [String] = ["Bloco 4, Apt 14","Bloco 5, Apt 23", "Bloco 2, Apt 34"]
    static var aptImage: [UIImage] = [ImagesMock.Apt.aptImage1!, ImagesMock.Apt.aptImage2!, ImagesMock.Apt.aptImage3!]
    static let aptImageNames: [String] = ["building", "building", "building"]
    static var aptValues: [String] = ["", "", ""]
    
    static let allapt: [String] = ["1","2","3","4","21","22","23","24","31","32","33","34","41","42","43","44","51","52","53","54"]
    static let allBloc: [String] = ["Bloco 1", "Bloco 2", "Bloco 3", "Bloco 4", "Bloco 5"]
}

struct Recreation {
    static var recreationTitle: [String] = ["Churrasqueira","Sauna", "Sala de Cinema","Quadra de Vôlei", "Quadra de Futebol", "Quadra de Tênis"]
    
    static var recreationImage: [UIImage] = [ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!]
    
    static var recreationValues: [String] = ["", "", "", "", "", ""]
}

struct PartyRoom {
    static var partyRoomTitle: [String] = ["Bloco 16, Apt 14","Bloco 20, Apt 23", "Bloco 16, Apt 34"]
    static var partyRoomImage: [UIImage] = [ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!]
    static var partyRoomValues: [String] = ["", "", ""]
}

struct Services {
    static var servicesTitle: [String] = ["Eletricista","Encanamento", "Manutenções"]
    static var servicesImage: [UIImage] = [ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!,ImagesMock.Recreation.aptImage1!]
    static var servicesValues: [String] = ["", "", ""]
}

struct Parking {
    static var parkingTitle: [String] = []
    static var parkingImage: [UIImage] = []
    static var parkingValues: [String] = []
}
