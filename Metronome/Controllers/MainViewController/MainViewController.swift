//
//  MainViewController.swift
//  Metronome
//
//  Created by User on 22.09.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK:- UIElements propeties
    var speedSlider: MySlider!
    var label: UILabel!
    var startButton: MyButton!
    var beatButton: MyButton!
    var pictureButton: MyButton!
    var appLabel: UILabel!
    var settingsButton: MyButton!
    var upButton: MyButton!
    var downButton: MyButton!
    var value = Constants.standartVal {
        didSet {
            let arrayndValue = 240 - oldValue
            startButton.stopBackground()
            startButton.changeBgrnd(frequency: Float(arrayndValue/10))
        }
    }
    var model: MainViewModelProtocol! {
        return MainViewModel()
    }
    
    //MARK:- UIElements configure
    
    func uIElementConfigure() {
        upButton = MyButton()
        downButton = MyButton()
        speedSlider = MySlider()
        startButton = MyButton()
        beatButton = MyButton()
        pictureButton = MyButton()
        settingsButton = MyButton()
        label = UILabel()
        appLabel = UILabel()
        
        label.font = Constants.robotoFont
        label.text = "\(Constants.standartVal)"
        label.textColor = .white
        label.textAlignment = .center
        layout()
        
        speedSlider.configure()
        startButton.backgroundColor = .red
        startButton.configureStartButton()
        beatButtonActionConfigure()
        pictureButtonActionConfigure()
        appLabel.text = Constants.appName
        appLabel.font = Constants.ubuntu
        startButton.imageInclude(image: "play")
        downButton.setImageToButton(image: "down")
        upButton.setImageToButton(image: "up")
        beatButton.litleButtonConfigurate(imageStr: "24")
        settingsButton.setImageToButton(image: "Settings")
        pictureButton.litleButtonConfigurate(imageStr: "Nota")
        settingsButton.addTarget(self, action: #selector(settingsButtonPress), for: .touchUpInside)
        speedSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        downButton.addTarget(self, action: #selector(downButtonPreess), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upButtonPreess), for: .touchUpInside)
    }
    
    @objc func downButtonPreess() {
        guard value >= 21 else {return}
        value -= 1
        label.text = "\(value)"
        speedSlider.setValue( Float(value), animated: true)
    }
    @objc func upButtonPreess() {
        guard value < Constants.maxVal, value >= Constants.minVal else {return}
        value += 1
        guard value > 0 else {return}
        label.text = "\(value)"
        speedSlider.setValue( Float(value), animated: true)
    }
    
    func layout() {
        view.addSubview(speedSlider)
        speedSlider.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(view.snp.bottom).multipliedBy(0.9)
            make.leading.greaterThanOrEqualTo(view.snp.leading).offset(+32)
            make.trailing.lessThanOrEqualTo(view.snp.trailing).offset(-32)
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(speedSlider.snp.top).offset(-30)
            make.height.equalTo(52)
            make.width.equalTo(95)
            make.centerX.equalTo(view.snp.centerX)
        }
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(228)
            make.width.equalTo(228)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(label.snp.top).offset(-17)
        }
        view.addSubview(beatButton)
        beatButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.leading.equalTo(startButton.snp.leading)
            make.bottom.equalTo(startButton.snp.top).offset(-33)
        }
        view.addSubview(pictureButton)
        pictureButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.leading.equalTo(beatButton.snp.trailing).offset(30)
            make.bottom.equalTo(startButton.snp.top).offset(-31)
        }
        view.addSubview(appLabel)
        appLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(125)
            make.height.greaterThanOrEqualTo(26)
            make.top.equalTo(view.snp.top).offset(100)
            make.bottom.lessThanOrEqualTo(beatButton.snp.top).offset(-5)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        view.addSubview(upButton)
        upButton.backgroundColor = .red
        upButton.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(43)
            make.bottom.equalTo(speedSlider.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(speedSlider.snp.leading).offset(-10)
        }
        view.addSubview(downButton)
        downButton.backgroundColor = .yellow
        downButton.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(43)
            make.bottom.equalTo(speedSlider.snp.bottom)
            make.leading.equalTo(speedSlider.snp.trailing).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
    }
    
    //MARK:- UIElements Actions
    
    func beatButtonActionConfigure() {
        beatButton.executeBeatsButton {
            UIAlertController.getAlert(type: .beats) { alert in
                self.present(alert, animated: true, completion: nil)
            } complessionOk: { beat in print(beat) }
        }
    }
    
    func pictureButtonActionConfigure() {
        pictureButton.executePictureButton {
            UIAlertController.getAlert(type: .picture) { alert in
                self.present(alert, animated: true, completion: nil)
            } complessionOk: { pict in
                print(pict)
            }
        }
    }
    
    @objc func settingsButtonPress() {
        MainStart.present(view: self, controller: .settingController)
    }
    
    @objc func sliderValueDidChange() {
        value = Int(speedSlider.value)
        let arrayndValue = 240 - value
        startButton.stopBackground()
        startButton.changeBgrnd(frequency: Float(arrayndValue/10))
        label.text = "\(value))"
    }
    
    //MARK:-  View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        uIElementConfigure()
    }
}

