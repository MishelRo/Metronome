//
//  UiTextField.swift
//  Metronome
//
//  Created by User on 28.09.2021.
//

import UIKit
extension UITextField {
    
    func getText()-> String{
        guard  let unrapedT = text else {return ""}
        return unrapedT
    }
    
    func getInt() -> Int{
        guard  let unrapedT = text else {return 0}
        guard let int = Int(unrapedT) else {return 0}
        return int
    }
}
