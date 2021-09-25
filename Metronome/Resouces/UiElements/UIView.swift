//
//  UIView.swift
//  Metronome
//
//  Created by User on 25.09.2021.
//

import UIKit
extension UIView
 {
    func makeVertical()
    {
         transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
 }
