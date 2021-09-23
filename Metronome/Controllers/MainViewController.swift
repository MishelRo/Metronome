//
//  MainViewController.swift
//  Metronome
//
//  Created by User on 22.09.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var speedSlider: MySlider!
    var label: UILabel!
    var startButton: MyButton!
    var beatButton: MyButton!
    var noteButton: MyButton!
    var appLabel: UILabel!
    var settingsButton: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2156666517, green: 0.2156973481, blue: 0.2156561911, alpha: 1)
        uiElementConfigure()
    }
    
    func uiElementConfigure() {
        
        speedSlider = MySlider()
        startButton = MyButton()
        beatButton = MyButton()
        noteButton = MyButton()
        settingsButton = MyButton()
        label = UILabel()
        appLabel = UILabel()

        label.font = UIFont(name: "Roboto", size: 48)
        label.text = "120"
        label.textColor = .white
        label.textAlignment = .center
        
        view.addSubview(speedSlider)
        speedSlider.configure()
        speedSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        speedSlider.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(view.snp.bottom).offset(-90)
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
        startButton.backgroundColor = .red
        startButton.configureStartButton()
        startButton.imageInclude(image: "play")
        startButton.snp.makeConstraints { make in
            make.height.equalTo(228)
            make.width.equalTo(228)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(label.snp.top).offset(-17)
        }
        view.addSubview(beatButton)
        beatButton.litleButtonConfigurate(imageStr: "24")
        beatButton.addTarget(self, action: #selector(beatPress), for: .touchUpInside)
        beatButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.leading.equalTo(startButton.snp.leading)
            make.bottom.equalTo(startButton.snp.top).offset(-31)
        }
        view.addSubview(noteButton)
        noteButton.litleButtonConfigurate(imageStr: "Nota")
        noteButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.leading.equalTo(beatButton.snp.trailing).offset(64)
            make.bottom.equalTo(startButton.snp.top).offset(-31)
        }
        view.addSubview(appLabel)
        appLabel.text = "Metronome"
        appLabel.font = UIFont(name: "Ubuntu", size: 23)
        appLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(125)
            make.height.greaterThanOrEqualTo(26)
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        view.addSubview(settingsButton)
        settingsButton.backgroundColor = .red
        settingsButton.setImageToButton(image: "Settings")
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
    
    @objc func beatPress() {
        UIAlertController.getAlert { alert in
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func sliderValueDidChange() {
        let val = speedSlider.value
        let arrayndValue = 240 - val
        startButton.stopBackground()
        startButton.changeBgrnd(frequency: arrayndValue/10)
        label.text = "\(Int(round(val)))"
    }
}
