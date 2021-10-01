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
            let standart = UIAlertAction(title: "standart", style: .default) { _ in  complessionOk("classic")};
            let triplett = UIAlertAction(title: "triplett", style: .default) { _ in  complessionOk("triplett")};
            let cowbell = UIAlertAction(title: "cowbell", style: .default) { _ in  complessionOk("cowbell")};
            let digital = UIAlertAction(title: "digital", style: .default) { _ in  complessionOk("digital")};
            let digitalDivision = UIAlertAction(title: "digital-Division", style: .default) { _ in  complessionOk("digital-Division")};
            let digitalTriplet = UIAlertAction(title: "digital-Triplet", style: .default) { _ in  complessionOk("digital-Triplet")};
            let subdivision = UIAlertAction(title: "Subdivision", style: .default) { _ in  complessionOk("Subdivision")};
            let sonarMain = UIAlertAction(title: "sonarMain", style: .default) { _ in  complessionOk("sonarMain")};
            let abletonMain = UIAlertAction(title: "abletonMain", style: .default) { _ in  complessionOk("abletonMain")};
            let logicMain = UIAlertAction(title: "logicMain", style: .default) { _ in  complessionOk("logicMain")};
            let cubaseMain = UIAlertAction(title: "cubaseMain", style: .default) { _ in  complessionOk("cubaseMain")};
            
            
            alert.addAction(standart)
            alert.addAction(triplett)
            alert.addAction(cowbell)
            alert.addAction(digital)
            alert.addAction(digitalDivision)
            alert.addAction(digitalTriplet)
            alert.addAction(subdivision)
            alert.addAction(sonarMain)
            alert.addAction(abletonMain)
            alert.addAction(logicMain)
            alert.addAction(cubaseMain)
            
            
            
            
            complession(alert)
        }
    }
    
}


