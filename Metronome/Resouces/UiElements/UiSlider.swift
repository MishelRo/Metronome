//
//  UiSlider.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//

import Foundation

import UIKit
class MySlider: UISlider {
    
    func configure() {
        self.minimumValue = 20
        self.maximumValue =  240
        self.value = 130
        thumbTintColor = .black
        minimumTrackTintColor = UIColor(hexString:"#747474")
        maximumTrackTintColor = UIColor(hexString: "#504F4F")
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
