//
//  UiSlider.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//

import Foundation

import UIKit
class MetronomeSlider: UISlider {
    
    func configure() {
        self.minimumValue = Float(Constants.minVal)
        self.maximumValue =  Float(Constants.maxVal)
        self.value = Float(Constants.standartVal)
        thumbTintColor = .black
        minimumTrackTintColor = UIColor(hexString:"#747474")
        maximumTrackTintColor = UIColor(hexString: "#504F4F")
        setThumbImage(UIImage(named: "seek"), for: UIControl.State.highlighted)
        setThumbImage(UIImage(named: "seek"), for: UIControl.State.normal)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
