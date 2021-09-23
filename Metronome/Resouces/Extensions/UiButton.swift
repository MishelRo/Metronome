//
//  UiButton.swift
//  Metronome
//
//  Created by User on 23.09.2021.
//

import UIKit
import UIKit
import SnapKit
import ChameleonFramework
@IBDesignable

class MyButton: UIButton {
    let arrayOfColors : [UIColor] = [ .systemPink,
                                      .systemOrange,
                                      .systemYellow,
                                      .systemBlue,
                                      .systemGreen]
    let view = UIView()
    let image = UIImageView()
    var play: Bool = false
    var timer: Timer?
    var complessionStart: (()->())!
    var complessionStop: (()->())!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (title: String ) {
        self.init (frame: .zero)
        setTitle(title, for: .normal)
    }
    
    func stopBackground() {
        timer?.invalidate()
        timer = nil
    }
    
    func setImageToButton(image: String){
        self.setImage(UIImage(named: image), for: .normal)
    }
    
    func setName(title: String) {
        setTitle(title, for: .normal)
    }
    
    func imageInclude(image str: String) {
        image.image = UIImage(named: "\(str)")
    }
    
    func configureStartButton() {
        let view = UIView()
        addSubview(view)
        view.backgroundColor = #colorLiteral(red: 0.2156666517, green: 0.2156973481, blue: 0.2156561911, alpha: 1)
        view.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(114)
            make.height.greaterThanOrEqualTo(114)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.top.equalTo(self.snp.top).offset(10)
            translatesAutoresizingMaskIntoConstraints = false
        }
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tabOnImage))
        view.addGestureRecognizer(recognizer)
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(100)
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        view.layer.cornerRadius = 104
        layer.cornerRadius = 114
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.1273057461, green: 0.8149128556, blue: 0.6144179702, alpha: 1)
    }
    
    @objc func tabOnImage(){
        stopBackground()
        play = !play
        if play{
            imageInclude(image: "pause")
            changeBgrnd(frequency: 12)
        } else {
            imageInclude(image: "play")
            //            complessionStop()
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    func litleButtonConfigurate(imageStr: String) {
        let view = UIView()
        addSubview(view)
        view.backgroundColor = #colorLiteral(red: 0.2156666517, green: 0.2156973481, blue: 0.2156561911, alpha: 1)
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(40)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            translatesAutoresizingMaskIntoConstraints = false
        }
        view.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(54.5)
            make.height.greaterThanOrEqualTo(54.5)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.top.equalTo(self.snp.top).offset(10)
            translatesAutoresizingMaskIntoConstraints = false
        }
        image.image = UIImage(named: imageStr)
        view.layer.cornerRadius = 45
        backgroundColor = #colorLiteral(red: 0.1273057461, green: 0.8149128556, blue: 0.6144179702, alpha: 1)
        layer.cornerRadius = 54.5
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension MyButton {
    func retrunrColor()-> UIColor{
        arrayOfColors.randomElement()!
    }
    
    func changeBgrnd(frequency: Float) {
        backgroundColor = .clear
        let interval = frequency / 15
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true) { [weak self] _ in
            guard let self = self else {return}
            let backgroundColor = GradientColor(gradientStyle: .leftToRight,
                                                    frame: UIScreen.main.bounds.integral,
                                                    colors: [self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor(),
                                                             self.retrunrColor() ])
                self.backgroundColor = backgroundColor
        }
    }
}
