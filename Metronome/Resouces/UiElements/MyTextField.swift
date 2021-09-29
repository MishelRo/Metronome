//
//  UiTextField.swift
//  Metronome
//
//  Created by User on 28.09.2021.
//

import UIKit
class MyTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        font = Constants.robotoFont
        text = "\(Constants.standartVal)"
        textColor = .white
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
