//
//  StackViewCel.swift
//  Metronome
//
//  Created by User on 26.09.2021.
//
protocol stackCellDelegate {
    func oneTab()
    func clean()
    func doubleTab()
}

import UIKit

class StackViewCel: NibLoadableView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var upImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    var selected: Bool = false
    var delegate: stackCellDelegate!
    var buttonFlashing = false
    
    
    
    func getFlash() {
        buttonFlashing = true
        upImage.alpha = 1
        
        UIView.animate(withDuration: 0.5 , delay: 0.0, options: [ .repeat], animations: {
            self.upImage.alpha = 0.2
        }, completion: {Bool in
        })
    }
    
    
    func stopFlashing() {
        buttonFlashing = false
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut,
                                                                .curveEaseIn,
                                                                .autoreverse,
                                                                .allowUserInteraction], animations: {
                                                                    self.upImage.alpha = 1
                                                                }, completion: {Bool in
                                                                })
    }
    
    func configure() {
        delegate = MainViewController()
        image.backgroundColor = Constants.MainBackgroundColor
        upImage.backgroundColor = Constants.MainBackgroundColor
        stackView.backgroundColor = Constants.MainBackgroundColor
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tabImage))
        addGestureRecognizer(tapImage)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTabImage))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        tapImage.require(toFail: doubleTap)
    }
    
    @objc func doubleTabImage() {
        selected = !selected
        if selected {
            stackView.backgroundColor = Constants.MainBackgroundColor
            image.image = imager.path(.unSelected)()
            upImage.image = imager.path(.unSelected)()
            delegate.doubleTab()
        }else {
            stackView.backgroundColor = Constants.MainBackgroundColor
            image.image = imager.path(.unSelected)()
            upImage.image = imager.path(.selected)()
        }
    }
    
    @objc func tabImage() {
        selected = !selected
        if selected {
            image.image = imager.path(.selected)()
            upImage.image = imager.path(.unSelected)()
            delegate.oneTab()
            getFlash()
        } else {
            stackView.backgroundColor = Constants.MainBackgroundColor
            image.image = imager.path(.selected)()
            upImage.image = imager.path(.selected)()
            delegate.clean()
            getFlash()
        }
    }
    
    static func make() -> UIView {
        let views = StackViewCel()
        views.backgroundColor = Constants.MainBackgroundColor
        views.configure()
        views.image.image = imager.path(.selected)()
        views.upImage.image = imager.path(.unSelected)()
        return views
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
