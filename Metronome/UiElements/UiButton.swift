//  UiButton.swift
//  Metronome
//
//  Created by User on 23.09.2021.

import UIKit
import SnapKit
import ChameleonFramework
@IBDesignable

class MetronomeButton: UIButton {
    let arrayOfColors : [UIColor] =  [ UIColor(hexString: "2AF598")!,
                                      UIColor(hexString: "009EFD")!,
                                      UIColor(hexString: "21E2AF")!,
                                      UIColor(hexString: "15CAC9")!,
                                      UIColor(hexString: "0AB3E4")! // массив цветов для градиента кнопок
    ]
    let view = UIView()
    let image = UIImageView()
    var play: Bool = false
    var timer: Timer?
    var frequency = 11
    var beat = Float(15)
    
    var complessionStart: (()->())! // действие старт
    var complessionStop: (()->())! // действие стоп
        
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
    
    func stopBackground() { // остановка плавающего градиента
        timer?.invalidate()
        timer = nil
    }
    
    func setImageToButton(image: UIImage){ // установка изображения для кнопок
        self.setImage(image, for: .normal)
    }
    
    func setName(title: String) { // установка названия кнопок
        setTitle(title, for: .normal)
    }
    
    func imageInclude(images: UIImage) {
        image.image = images
        image.contentMode = .center
    }
    
    func configureStartButton() { // конфигуратор стартовой кнопки
        var cornerStart = 104
           var layerCorner = 114
        
        if UIScreen.isPhone7(){
            cornerStart = 73
            layerCorner = 83
        }
        
        if UIScreen.isPhone8() {
            cornerStart = 73
            layerCorner = 83
        }
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.top.equalTo(self.snp.top).offset(10)
        }
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tabOnImage)) // распознование нажатия
        view.backgroundColor = Constants.MainBackgroundColor
        backgroundColor = Constants.littleButtonBackground
        view.addGestureRecognizer(recognizer)
        view.layer.cornerRadius = CGFloat(cornerStart)/////////////////////////////////////////
        layer.cornerRadius = CGFloat(layerCorner)//////////////////////////////////////////////////
    }
    
    @objc func tabOnImage() { // нажатие на кнопку
        stopBackground()
        play = !play
        if play{
            complessionStop()
            imageInclude(images: imager.path(.pause)())
        } else {
            complessionStart()
            imageInclude(images: imager.path(.play)())
            timer?.invalidate()
            timer = nil
        }
    }
    
    func startConfigure(action: @escaping (()->())) { // обнвление действия по нажатию старт
        complessionStart = action
    }
    func stopConfigure(action: @escaping (()->())) { // обнвление действия по нажатию стоп
        complessionStop = action
    }
    
    func litleButtonConfigurate(imageStr: UIImage) { // конфигуратор кнопок бит и рисунок
        var cornerStart = 45
        var layerCorner = 54.5
        if UIScreen.isPhone7(){
            cornerStart = 35
            layerCorner = 42
        }
        addSubview(view)
        view.backgroundColor = Constants.MainBackgroundColor
        view.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(39)
            make.height.lessThanOrEqualTo(27)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            translatesAutoresizingMaskIntoConstraints = false
        }
        view.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(57.5)
            make.height.greaterThanOrEqualTo(57.5)
            make.bottom.equalTo(self.snp.bottom).offset(-7.5)
            make.leading.equalTo(self.snp.leading).offset(7.5)
            make.trailing.equalTo(self.snp.trailing).offset(-7.5)
            make.top.equalTo(self.snp.top).offset(7.5)
        }
        image.image = imageStr
        view.layer.cornerRadius = CGFloat(cornerStart)
        backgroundColor = Constants.littleButtonBackground
        layer.cornerRadius = CGFloat(layerCorner)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(littleButtonHandleTap)) // распознование нажатия
        view.addGestureRecognizer(tap)
    }
    
    func executeBeatsButton(action: @escaping (()->())) {  // обнвление действия по нажатию конпок бит
        complessionStart = action
    }
    func executePictureButton(action: @escaping (()->())) {// обнвление действия по нажатию конпок рисунок
        complessionStart = action
    }
    
    @objc func littleButtonHandleTap() {
        complessionStart()
    }
}

//MARK:- gradient Imp

extension MetronomeButton {
    func retrunrColor()-> UIColor{ // возвращает рандомный элемент цвета
        arrayOfColors.randomElement()!
    }
    
    func  changeBuBpmBack() {
        self.backgroundColor = GradientColor(.diagonal, frame: UIScreen.main.bounds.integral, colors: [self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor(),
                                                                                                       self.retrunrColor() ])
    }
}
