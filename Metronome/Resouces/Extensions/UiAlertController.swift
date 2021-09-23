//
//  UiAlertController.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//
enum alertChoose {
    case beats
    case picture
}


import UIKit
extension UIAlertController {
    
    static func getAlert(type: alertChoose, complession: @escaping(UIAlertController)->()) {
        switch type {
        case .beats:
            let alert = UIAlertController(title: "Сhoose a bit)", message: "", preferredStyle: .actionSheet)
            let beatOne = UIAlertAction(title: "2", style: .default) { _ in }
            let beatTwo = UIAlertAction(title: "3", style: .default) { _ in }
            let beatFour = UIAlertAction(title: "4/4", style: .default) { _ in }
            alert.addAction(beatOne)
            alert.addAction(beatTwo)
            alert.addAction(beatFour)
            complession(alert)
        case .picture:
            let alert = UIAlertController(title: "Сhoose a picture", message: "", preferredStyle: .actionSheet)
            let beatOne = UIAlertAction(title: "pict 1", style: .default) { _ in }
            let beatTwo = UIAlertAction(title: "pict 2", style: .default) { _ in }
            let beatFour = UIAlertAction(title: "pict 3", style: .default) { _ in }
            alert.addAction(beatOne)
            alert.addAction(beatTwo)
            alert.addAction(beatFour)
            complession(alert)
        }
    }
}
