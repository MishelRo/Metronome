//  UiButton.swift
//  Metronome
//
//  Created by User on 23.09.2021.

import UIKit
import UIKit
import SnapKit
import ChameleonFramework
@IBDesignable

class MetronomeButton: UIButton {
    let arrayOfColors : [UIColor] =  [UIColor(hexString: "2AF598"),
                                      UIColor(hexString: "009EFD"),
                                      UIColor(hexString: "21E2AF"),
                                      UIColor(hexString: "15CAC9"),
                                      UIColor(hexString: "0AB3E4") // массив цветов для градиента кнопок
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
        view.layer.cornerRadius = 104
        layer.cornerRadius = 114
    }
    
    @objc func tabOnImage() { // нажатие на кнопку
        stopBackground()
        play = !play
        if play{
            complessionStop()
            imageInclude(images: name.path(.pause)())
            changeBgrnd(frequency: Float(frequency))
        } else {
            complessionStart()
            imageInclude(images: name.path(.play)())
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
        addSubview(view)
        view.backgroundColor = Constants.MainBackgroundColor
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(55)
            make.height.lessThanOrEqualTo(40)
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
        view.layer.cornerRadius = 45
        backgroundColor = Constants.littleButtonBackground
        layer.cornerRadius = 54.5
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
    
    func changeBgrnd(frequency: Float) { // возвращает в фон кнопки градиент согласно заданной частоты
        self.frequency = Int(frequency)
        let interval = frequency / (beat * 1.6)
        if play{
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true) { [weak self] _ in
            guard let self = self else {return}
            let backgroundColor = GradientColor(gradientStyle: .topToBottom,
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
}
