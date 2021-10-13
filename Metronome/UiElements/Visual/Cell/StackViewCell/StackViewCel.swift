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
    
    
    var doubleTabComplessionSelected: (()->())!
    var doubleTabComplessionUnSelected: (()->())!

    var oneTabComplession: (()->())!
    var unselected: (()->())!
    
    
    
    func configure() {
        delegate = MainViewController()
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
            image.image = imager.path(.unSelected)()
            upImage.image = imager.path(.unSelected)()
            delegate.doubleTab()
            doubleTabComplessionSelected()
        }else {
            image.image = imager.path(.unSelected)()
            upImage.image = imager.path(.selected)()
            doubleTabComplessionUnSelected()
        }
    }
    
    @objc func tabImage() {
        selected = !selected
        if selected {
            oneTabComplession()
            image.image = imager.path(.selected)()
            upImage.image = imager.path(.unSelected)()
            delegate.oneTab()
        } else {
            unselected()
            image.image = imager.path(.selected)()
            upImage.image = imager.path(.selected)()
            delegate.clean()
        }
    }
    
    static func make(oneTabComplession: @escaping (()->()),
                     unselected: @escaping (()->()),
                     doubleTabComplessionSelected: @escaping (()->()),
                     doubleTabComplessionUnSelected: @escaping (()->())  ) -> UIView {
        let views = StackViewCel()
        
        views.oneTabComplession = oneTabComplession
        views.unselected = unselected
        views.doubleTabComplessionSelected = doubleTabComplessionSelected
        views.doubleTabComplessionUnSelected = doubleTabComplessionUnSelected
        
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


