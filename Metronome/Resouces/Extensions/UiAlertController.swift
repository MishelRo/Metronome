//
//  UiAlertController.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//
enum alertChoose {
    case beats
    case picture
    case soundChange
}


import UIKit
extension UIAlertController {
    
    static func getAlert(type: alertChoose, complession: @escaping(UIAlertController)->(),
                         complessionOk: @escaping(String)->()) {
        switch type {
        case .beats:
            let alert = UIAlertController(title: "Размер", message: "", preferredStyle: .actionSheet)
            let beatOne = UIAlertAction(title: "2", style: .default) { _ in complessionOk("2")}
            let beatTwo = UIAlertAction(title: "3", style: .default) { _ in complessionOk("3")}
            let beatFour = UIAlertAction(title: "4/4", style: .default) { _ in complessionOk("4")}
            if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                for innerView in actionSheet.subviews {
                    innerView.backgroundColor = Constants.allertColor
                }
            }
            alert.addAction(beatOne)
            alert.addAction(beatTwo)
            alert.addAction(beatFour)
            complession(alert)
        case .picture:
            let alert = UIAlertController(title: "Рисунок", message: "", preferredStyle: .actionSheet)
            if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                for innerView in actionSheet.subviews {
                    innerView.backgroundColor = Constants.allertColor
                }
            }
            let pictOne = UIAlertAction(title: "pict 1", style: .default) { _ in  complessionOk("pict1")}
            let pictTwo = UIAlertAction(title: "pict 2", style: .default) { _ in complessionOk("pict2")}
            let pictThree = UIAlertAction(title: "pict 3", style: .default) { _ in  complessionOk("pict3")}
            alert.addAction(pictOne)
            alert.addAction(pictTwo)
            alert.addAction(pictThree)
            complession(alert)
        case .soundChange:
            let alert = UIAlertController(title: "Выберете Мелодию", message: "", preferredStyle: .actionSheet)
            if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                for innerView in actionSheet.subviews {
                    innerView.backgroundColor = Constants.allertColor
                }
            }
            let standart = UIAlertAction(title: "standart", style: .default) { _ in  complessionOk("standart")}
            let light = UIAlertAction(title: "light", style: .default) { _ in complessionOk("light")}
            let custom = UIAlertAction(title: "custom", style: .default) { _ in  complessionOk("custom")}
            let other = UIAlertAction(title: "other", style: .default) { _ in  complessionOk("other")}
            let digital = UIAlertAction(title: "digital", style: .default) { _ in  complessionOk("digital")}
            let triplet = UIAlertAction(title: "triplet", style: .default) { _ in  complessionOk("triplet")}
            let subDevision = UIAlertAction(title: "subDevision", style: .default) { _ in  complessionOk("subDevision")};
            
            alert.addAction(standart)
            alert.addAction(light)
            alert.addAction(custom)
            alert.addAction(other)
            alert.addAction(digital)
            alert.addAction(triplet)
            alert.addAction(subDevision)
            
            complession(alert)
        }
    }
    
}


