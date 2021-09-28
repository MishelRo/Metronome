//
//  CustomAlert.swift
//  Metronome
//
//  Created by User on 28.09.2021.
//

import UIKit
import SnapKit

class CustomAlert: UIView {

    var label: UILabel!
    
    func configure(labelText: String) {
        label = UILabel()
        addSubview(label)
        label.text = labelText
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(58)
        }
    }
    
    
    init(labelText: String) {
        super.init(frame: .zero)
        configure(labelText: labelText)
        backgroundColor = Constants.allertColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

