//
//  Equalizer.swift
//  Metronome
//
//  Created by User on 26.09.2021.
//
import SnapKit
import UIKit

class Equalizer: UIView {
    
    var stackView: UIStackView!
    
    
    func configure() {
        stackView = UIStackView()
        backgroundColor = Constants.MainBackgroundColor
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    
    func addVisual(count: Int) {
        switch count {
        case 1:
            [ StackViewCel.make(selected: true) ].forEach { stackView.addArrangedSubview($0) }
        case 2:
            [ StackViewCel.make(selected: true), StackViewCel.make(selected: false) ].forEach { stackView.addArrangedSubview($0) }
        case 3:
            [   StackViewCel.make(selected: true),
                StackViewCel.make(selected: false),
                StackViewCel.make(selected: false), ].forEach { stackView.addArrangedSubview($0) }
        case 4:
            [   StackViewCel.make(selected: true),
                StackViewCel.make(selected: false),
                StackViewCel.make(selected: false),
                StackViewCel.make(selected: false) ].forEach { stackView.addArrangedSubview($0) }
        default : break
        }
    }
    
    
    
     init(count: Int) {
        super.init(frame: .zero)
        configure()
        stackView.removeSubviews()
        addVisual(count: count)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
