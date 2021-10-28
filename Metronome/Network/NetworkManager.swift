//
//  NetworkManager.swift
//  Metronome
//
//  Created by User on 19.10.2021.
//

import UIKit
import KeychainSwift
import FirebaseDatabase


class NetworkManager {
    
    let ref = Database.database(url: "https://metronomeapp-f22d5-default-rtdb.firebaseio.com/")
    let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)

    
    func registerOfStartIfAuth() {
        guard  let token = KeychainSwift().get("token") else {return}
        guard let name = KeychainSwift().get("name") else {return}
        guard let email = KeychainSwift().get("email") else {return}
        let dict = [timestamp : [token: email]]
        ref.reference().child("\(name)").child("register").updateChildValues(dict)
    }
    
    func registerOfStart() {
        guard  let token = KeychainSwift().get("token") else {
            let dict = [timestamp : ["anonim": "anonim@mail.ru"]]
            ref.reference().child("\("anonim")").child("incoming").updateChildValues(dict);

            return}
        guard let name = KeychainSwift().get("name") else {return}
        guard let email = KeychainSwift().get("email") else {return}
        let dict = [timestamp : [token: email]]
        ref.reference().child("\(name)").child("incoming").updateChildValues(dict)
    }
    
    
    func registerOfStartIsNotAuth() {

    }
    
    
}
