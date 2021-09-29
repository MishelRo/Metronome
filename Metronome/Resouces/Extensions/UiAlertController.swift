//
//  UiAlertController.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//
enum alertChoose {
    case soundChange
}


import UIKit
extension UIAlertController {
    
    static func getAlert(type: alertChoose, complession: @escaping(UIAlertController)->(),
                         complessionOk: @escaping(String)->()) {
        switch type {
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


