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
    
    
    //MARK:- UIElements configure
    
    func uiElementConfigure() {
        speedSlider = MySlider()
        startButton = MyButton()
        beatButton = MyButton()
        pictureButton = MyButton()
        settingsButton = MyButton()
        label = UILabel()
        appLabel = UILabel()
        label.font = Constants.robotoFont
        label.text = "130"
        label.textColor = .white
        label.textAlignment = .center
        layout()
        
        speedSlider.configure()
        speedSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        startButton.backgroundColor = .red
        startButton.configureStartButton()
        startButton.imageInclude(image: "play")
        beatButton.litleButtonConfigurate(imageStr: "24")
        beatButtonActionConfigure()
        pictureButton.litleButtonConfigurate(imageStr: "Nota")
        pictureButtonActionConfigure()
        appLabel.text = Constants.appName
        appLabel.font = Constants.ubuntu
        
    }
    
    func layout() {
        view.addSubview(speedSlider)
        speedSlider.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(view.snp.bottom).multipliedBy(0.9)
            make.leading.equalTo(view.snp.leading).offset(+40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
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
    }
    
    //MARK:- UIElements Actions
    
    func beatButtonActionConfigure() {
        beatButton.executeBeatsButton {
            UIAlertController.getAlert(type: .beats) { alert in
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func pictureButtonActionConfigure() {
        pictureButton.executePictureButton {
            UIAlertController.getAlert(type: .picture) { alert in
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func settingsButtonPress() {
        MainStart.present(view: self, controller: .settingController)
    }
    
    @objc func sliderValueDidChange() {
        let val = speedSlider.value
        let arrayndValue = 240 - val
        startButton.stopBackground()
        startButton.changeBgrnd(frequency: arrayndValue/10)
        label.text = "\(Int(round(val)))"
    }
    
    //MARK:-  View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        uiElementConfigure()
    }
    
}

