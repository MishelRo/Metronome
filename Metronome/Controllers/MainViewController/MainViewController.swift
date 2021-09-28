//
//  MainViewController.swift
//  Metronome
//
//  Created by User on 22.09.2021.
//

import UIKit
import SnapKit
import AVFoundation

class MainViewController: UIViewController {
    
    //MARK:- UIElements propeties
    
    var pageControl: UIPageControl!
    var speedSlider: MySlider!
    var startButton: MyButton!
    var beatButton: MyButton!
    var pictureButton: MyButton!
    var appLabel: UILabel!
    var settingsButton: MyButton!
    var upButton: MyButton!
    var downButton: MyButton!
    var countArray = [Int]()
    var changeSoundButton: MyButton!
    var equalizerView: Equalizer!
    var alertBeat: CustomAlert!
    var alertPict: CustomAlert!
    var valueTextField: UITextField!

    
    //MARK:- Class Propeties
    
    private var start = false
    private var timer: Timer!
    private var jumptimer: Timer?
    private var currentPage = 0
    private var numberOfPages = 5
    private var model = MainViewModel()
    
    private var value = Constants.standartVal {
        didSet {
            let arrayndValue = 240 - oldValue
            startButton.stopBackground()
            startButton.changeBgrnd(frequency: Float(arrayndValue/10))
        }
    }
    
    private var beatCount = 1 {
        didSet {
            equalizerView = nil
            pageControl.numberOfPages = beatCount
            equalizerView = Equalizer(count: beatCount)
            guard beatCount == 0 else {return}
            numberOfPages = 1
            equalizerView = Equalizer(count: 1)
        }
    }
    
    //MARK:- UIElements configure
    
    private func uIElementConfigure() {
        model.audioPlayer = SoundPlayer(model: .standart)
        pageControl = UIPageControl()
        equalizerView = Equalizer(count: 4)
        upButton = MyButton()
        downButton = MyButton()
        speedSlider = MySlider()
        startButton = MyButton()
        beatButton = MyButton()
        pictureButton = MyButton()
        settingsButton = MyButton()
        changeSoundButton = MyButton()
        valueTextField = UITextField()
        appLabel = UILabel()
        alertBeat = CustomAlert()
        alertPict = CustomAlert()
        alertBeat.configure(labelText: "Размер")
        alertPict.configurePict(labelText: "Рисунок")
        elementSettings()
    }
    
    private func elementSettings() {
        model.delegate = self
        valueTextField.font = Constants.robotoFont
        valueTextField.text = "\(Constants.standartVal)"
        valueTextField.textColor = .white
        valueTextField.textAlignment = .center
        layout()
        speedSlider.configure()
        startButton.backgroundColor = .red
        startButton.configureStartButton()
        startButtonStartConfigure()
        startButtonStopConfigure()
        beatButtonActionConfigure()
        pictureButtonActionConfigure()
        appLabel.text = Constants.appName
        appLabel.font = Constants.ubuntu
        appLabel.textColor = .white
        startButton.imageInclude(images: name.path(.play)())
        
        downButton.setImageToButton(image: name.path(.down)())
        upButton.setImageToButton(image: name.path(.up)())
        changeSoundButton.setImageToButton(image: name.path(.buttonNota)())
        beatButton.litleButtonConfigurate(imageStr: name.path(.twoFour)())
        settingsButton.setImageToButton(image: name.path(.setting)())
        pictureButton.litleButtonConfigurate(imageStr: name.path(.nota)())
        settingsButton.addTarget(self, action: #selector(settingsButtonPress), for: .touchUpInside)
        speedSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        downButton.addTarget(self, action: #selector(downButtonPreess), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upButtonPreess), for: .touchUpInside)
        changeSoundButton.addTarget(self, action: #selector(changeSoundButtonPress), for: .touchUpInside)
        alertPict.setupImageToButton(firstImage: name.path(.OneNota)(),
                                     SecondImage: name.path(.twoNota)(),
                                     thirstImage: name.path(.nota3)())
        valueTextField.addTarget(self, action: #selector(changeValyebyTab), for: .editingDidEndOnExit)
    }
    
    @objc func changeValyebyTab() {
       let val = valueTextField.getInt()
        guard val > 19, val < 241 else { valueTextField.text = "130"; return}
        self.value = val
        speedSlider.value = Float(val)
        guard start else {return}
        
        value = Int(speedSlider.value)
        let arrayndValue = Constants.maxVal - value
        startButton.stopBackground()
        startButton.changeBgrnd(frequency: Float(arrayndValue/10))

        
        stopStartTick()
        startTick()
    }
    
    
    private func layout() {
        view.addSubview(appLabel)
        appLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(125)
            make.height.greaterThanOrEqualTo(26)
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(120)
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(view.snp.centerX)
            make.top.lessThanOrEqualTo(appLabel.snp.top).offset(20)
        }
        self.view.addSubview(equalizerView)
        equalizerView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(240)
            make.height.equalTo(50)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(pageControl.snp.bottom).offset(10)
        }
        view.addSubview(beatButton)
        beatButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.trailing.greaterThanOrEqualTo(view.snp.centerX).offset(-10)
            make.top.greaterThanOrEqualTo(equalizerView.snp.bottom).offset(20)
        }
        view.addSubview(pictureButton)
        pictureButton.snp.makeConstraints { make in
            make.height.equalTo(109)
            make.width.equalTo(109)
            make.leading.greaterThanOrEqualTo(view.snp.centerX).offset(15)
            make.top.greaterThanOrEqualTo(equalizerView.snp.bottom).offset(20)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(228)
            make.width.equalTo(228)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(pictureButton.snp.bottom).offset(40)
            make.top.equalTo(beatButton.snp.bottom).offset(40)
        }
        
        view.addSubview(valueTextField)
        valueTextField.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(startButton.snp.bottom).offset(20)
            make.height.equalTo(52)
            make.width.equalTo(110)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(speedSlider)
        speedSlider.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(view.snp.bottom).offset(-100)
            make.top.greaterThanOrEqualTo(valueTextField.snp.bottom).offset(35)
            make.leading.greaterThanOrEqualTo(view.snp.leading).offset(+32)
            make.trailing.lessThanOrEqualTo(view.snp.trailing).offset(-32)
            make.height.equalTo(10)
        }
        
        view.addSubview(upButton)
        upButton.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(43)
            make.bottom.equalTo(speedSlider.snp.bottom).offset(15)
            make.leading.equalTo(speedSlider.snp.trailing).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        view.addSubview(downButton)
        downButton.snp.makeConstraints { make in
            make.width.equalTo(43)
            make.height.equalTo(43)
            make.bottom.equalTo(speedSlider.snp.bottom).offset(15)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(speedSlider.snp.leading).offset(-10)
        }
        
        pageControl.numberOfPages = beatCount
        pageControl.currentPage = currentPage
        
        self.view.addSubview(changeSoundButton)
        changeSoundButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
            make.trailing.equalTo(settingsButton.snp.trailing).offset(-50)
        }
        
    }
    
    //MARK:- UIElements Actions
    
    @objc func changeSoundButtonPress() {
        UIAlertController.getAlert(type: .soundChange) { alert in
            self.present(alert, animated: true, completion: nil)
        } complessionOk: { [self] value in
            beatCount = 1
            let sound = model.bit(value: value)
            model.audioPlayer = sound
        }
    }
    
    @objc func downButtonPreess() {
        pageControl.currentPage -= 1
        guard value >= 21 else {return}
        value -= 1
        valueTextField.text = "\(value)"
        speedSlider.setValue( Float(value), animated: true)
        guard start else {return}
        stopStartTick()
        startTick()
    }
    
    @objc func upButtonPreess() {
        guard value < Constants.maxVal, value >= Constants.minVal else {return}
        value += 1
        pageControl.currentPage += 1
        guard value > 0 else {return}
        valueTextField.text = "\(value)"
        speedSlider.setValue( Float(value), animated: true)
        guard start else {return}
        stopStartTick()
        startTick()
    }
    
    @objc func settingsButtonPress() {
        MainStart.present(view: self, controller: .settingController)
    }
    
    @objc func sliderValueDidChange() {
        value = Int(speedSlider.value)
        let arrayndValue = Constants.maxVal - value
        startButton.stopBackground()
        startButton.changeBgrnd(frequency: Float(arrayndValue/10))
        valueTextField.text = "\(value)"
        guard start else {return}
        stopStartTick()
        startTick()
    }
    
    private func beatButtonActionConfigure() {
        countArray = [Int]()
        beatButton.executeBeatsButton {
            self.view.addSubview(self.alertBeat)
            self.alertBeat.isHidden = false
            self.alertBeat.snp.makeConstraints { make in
                make.width.equalTo(self.view.snp.width)
                make.height.equalTo(self.view.frame.height / 3)
                make.bottom.equalTo(self.view.snp.bottom)
            }
        }
    }
    
    private func pictureButtonActionConfigure() {
        self.pictureButton.executeBeatsButton {
            self.view.addSubview(self.alertPict)
            self.alertPict.isHidden = false
            self.alertPict.snp.makeConstraints { make in
                make.width.equalTo(self.view.snp.width)
                make.height.equalTo(self.view.frame.height / 3)
                make.bottom.equalTo(self.view.snp.bottom)
            }
        }
    }
    //MARK:- AllertConfigure
    
    private func alertPictConfigure() {
        alertPict.complessionFirst = pictOne
        alertPict.complessionSecond = pictTwo
        alertPict.complessionThird = pictThree
        
    }
    
    private func pictOne() {
        self.alertPict.isHidden = true
        guard self.start else {return}
        self.beatCount = 2
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
        self.stopJumpTimer()
        self.stopJumpTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            self.model.animate(bpm: self.value)
            self.jumptimer = self.model.timerReturn(timeInterval: Constants.timeInterval,
                                                    bpm: Double(self.value))
        }
    }
    private func pictTwo() {
        self.alertPict.isHidden = true
        guard self.start else {return}
        self.beatCount = 3
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
        self.stopJumpTimer()
        self.stopJumpTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            self.model.animate(bpm: self.value)
            self.jumptimer = self.model.timerReturn(timeInterval: Constants.timeInterval,
                                                    bpm: Double(self.value))
        }
    }
    private func pictThree() {
        self.alertPict.isHidden = true
        guard self.start else {return}
        self.beatCount = 4
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
        self.stopJumpTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7){
            self.model.animate(bpm: self.value)
            self.jumptimer = self.model.timerReturn(timeInterval: Constants.timeInterval,
                                                    bpm: Double(self.value))
        }
    }
    
    private func alertConfigure() {
        alertBeat.complessionFirst = beatOne
        alertBeat.complessionSecond = beatTwo
        alertBeat.complessionThird = beatThree
        
    }
    
    private func beatOne() {
        self.beatCount = 2
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
    }
    private func beatTwo() {
        self.beatCount = 3
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
    }
    private func beatThree() {
        self.beatCount = 4
        self.changeBeat(count: self.beatCount)
        self.alertBeat.isHidden = true
    }
    
    
    
    //MARK:-  View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        uIElementConfigure()
        alertConfigure()
        alertPictConfigure()
        valueTextField.keyboardType = .phonePad
    }
    
    //MARK:- KeyBoard Jump Settings
    
    override func viewWillAppear(_ animated: Bool) {
         self.addKeyboardObserver()
     }

     override func viewWillDisappear(_ animated: Bool) {
         self.removeKeyboardObserver()
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        alertBeat.isHidden = true
        alertPict.isHidden = true
    }
    
}
//MARK:- Timer

extension MainViewController: TickDelegate {
    
    func tick(count: Int) {
        self.countArray.append(count)
        guard self.countArray.count <= self.beatCount - 1 else {
            self.countArray = [Int](); return
                self.pageControl.currentPage = 0 }
        self.pageControl.currentPage = self.countArray.count
    }
    
    private func stopJumpTimer() {
        jumptimer?.invalidate()
        jumptimer = nil
    }
    
    private func startButtonStartConfigure() {
        startButton.startConfigure {
            self.stopStartTick()
        }
    }
    
    private func startButtonStopConfigure() {
        startButton.stopConfigure {
            self.startTick()
        }
    }
    
    private func stopStartTick() {
        UIApplication.shared.isIdleTimerDisabled = false
        guard start != false else {return}
        start = false
        timer.invalidate()
        jumptimer?.invalidate()
        timer = nil
        model.animate(bpm: value)
    }
    
    private func startTick() {
        UIApplication.shared.isIdleTimerDisabled = true
        start = true
        model.animate(bpm: value)
        timer = model.timerReturn(timeInterval: 60.0, bpm: Double(value))
    }
    
    private func changeBeat(count: Int) {
        guard self.start else {return}
        stopStartTick()
        model.audioPlayer?.changeBeats(beats: count)
        startTick()
    }
}

