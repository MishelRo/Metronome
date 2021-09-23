//
//  UiAlertController.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//

import UIKit
extension UIAlertController {
    
    static func getAlert(complession: @escaping(UIAlertController)->()) {
        let alert = UIAlertController(title: "Сhoose a bit)", message: "", preferredStyle: .actionSheet)
        let beatOne = UIAlertAction(title: "2", style: .default) { _ in }
        let beatTwo = UIAlertAction(title: "3", style: .default) { _ in }
        let beatFour = UIAlertAction(title: "4/4", style: .default) { _ in }
        alert.addAction(beatOne)
        alert.addAction(beatTwo)
        alert.addAction(beatFour)
        complession(alert)
    }
    
}
