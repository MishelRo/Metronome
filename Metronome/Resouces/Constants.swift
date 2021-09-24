//
//  Constants.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import UIKit
import ChameleonFramework

class Constants {
    static var MainBackgroundColor = #colorLiteral(red: 0.2156666517, green: 0.2156973481, blue: 0.2156561911, alpha: 1)
    static var robotoFont = UIFont(name: "Roboto", size: 48)
    static var ubuntu = UIFont(name: "Ubuntu", size: 23)
    static var appName = "Metronome"
    static var standartVal = 130
    static var maxVal = 240
    static var minVal = 20
    static var littleButtonBackground = GradientColor(gradientStyle: .topToBottom,
                                                      frame: UIScreen.main.bounds.integral,
                                                      colors: [#colorLiteral(red: 0, green: 0.6315296888, blue: 0.9803366065, alpha: 1), #colorLiteral(red: 0.163719058, green: 0.9479225278, blue: 0.606187582, alpha: 1), #colorLiteral(red: 0.163719058, green: 0.9479225278, blue: 0.606187582, alpha: 1), #colorLiteral(red: 0.163719058, green: 0.9479225278, blue: 0.606187582, alpha: 1)])
}

