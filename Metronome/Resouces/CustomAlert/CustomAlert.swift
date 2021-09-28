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
    var firstButton: UIButton!
    var secondButton: UIButton!
    var thirdButton: UIButton!
    var lineView: UIView!

    var complessionFirst: (()->())!
    var complessionSecond: (()->())!
    var complessionThird: (()->())!
    
    func configure(labelText: String) {
        label = UILabel()
        firstButton = UIButton()
        secondButton = UIButton()
        thirdButton = UIButton()
        lineView = UIView()

        addSubview(label)
        label.text = labelText
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto", size: 26)
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(58)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            lineView.backgroundColor = #colorLiteral(red: 0.4548649788, green: 0.4549226761, blue: 0.4548452497, alpha: 1)
            make.top.equalTo(label.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.width.equalTo(label.snp.width)
        }
        
        addSubview(firstButton)
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.width.lessThanOrEqualTo(85)
            make.centerX.equalTo(snp.centerX)
        }
        addSubview(secondButton)
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(15)
            make.height.equalTo(firstButton.snp.height)
            make.width.equalTo(firstButton.snp.width)
            make.centerX.equalTo(snp.centerX)
        }
        addSubview(thirdButton)
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(secondButton.snp.bottom).offset(15)
            make.height.equalTo(secondButton.snp.height)
            make.width.equalTo(secondButton.snp.width)
            make.centerX.equalTo(snp.centerX)
        }
        self.firstButton.addTarget(self, action: #selector(firstButtonTabConfigure), for: .touchUpInside)
        self.secondButton.addTarget(self, action: #selector(secondButtonTabConfigure), for: .touchUpInside)
        self.thirdButton.addTarget(self, action: #selector(thirdButtonTabConfigure), for: .touchUpInside)
    }
    
    func beatConfigure() {
        firstButton.setTitle("2      ", for: .normal)
        firstButton.setSubstituteFontName("Roboto")
        secondButton.setSubstituteFontName("Roboto")
        thirdButton.setSubstituteFontName("Roboto")
        secondButton.setTitle("3      ", for: .normal)
        thirdButton.setTitle("   4   /   4", for: .normal)
    }
    
    @objc func firstButtonTabConfigure() {
        complessionFirst()
    }
    
    @objc func secondButtonTabConfigure() {
        complessionSecond()
    }
    
    @objc func thirdButtonTabConfigure() {
        complessionThird()
    }
    
    
    
    func pictConfigure() {
     
    }
    
    func setupImageToButton(firstImage: String, SecondImage: String, thirstImage: String) {
        firstButton.setImage(UIImage(named: firstImage), for: .normal)
        secondButton.setImage(UIImage(named: SecondImage), for: .normal)
        thirdButton.setImage(UIImage(named: thirstImage), for: .normal)
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

