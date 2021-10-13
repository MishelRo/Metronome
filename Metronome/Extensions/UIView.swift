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
    
 @objc func flash() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.1
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 0
    layer.add(flash, forKey: nil)
    }
    
    
        func getFlash() {
            alpha = 1
            UIView.animate(withDuration: 0.1 , delay: 0, animations: {
                if UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle == .dark {
                    self.alpha = 0.7
                self.backgroundColor = .black
                } else {
                self.backgroundColor = .white
                    self.alpha = 0.7
                }
            }, completion: {_ in
                self.alpha = 1
                self.backgroundColor = Constants.MainBackgroundColor
            })
        }
 }
