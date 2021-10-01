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
    var speedSlider: MetronomeSlider!
    var startButton: MetronomeButton!
    var beatButton: MetronomeButton!
    var pictureButton: MetronomeButton!
    var appLabel: MetronomeLabel!
    var settingsButton: MetronomeButton!
    var upButton: MetronomeButton!
    var downButton: MetronomeButton!
    var changeSoundButton: MetronomeButton!
    var equalizerView: Equalizer!
    var alertBeat: MetronomeAlert!
    var alertPict: MetronomeAlert!
    var valueTextField: MetronomeTextField!
    var pictureLabel: MetronomeLabel!
    var beatLabel: MetronomeLabel!
    
    //MARK:- Class Propeties
    
    private var currentPage = 0
    private var numberOfPages = 5
    private var model = MainViewModel()
    
    var metronome: Metronome!
    var countBeat: Int32 = 0 // количество бпм
    var timeSignature: Int32 = 1 // количество нот
    var tempo: Int32 = 130 { // темп
        didSet {
            valueTextField.text = String(tempo)
        }
    }
    var scheme: UrlSoundModel!

    //MARK:- UIElements configure
    
    private func uIElementConfigure() {
        pageControl = UIPageControl()
        equalizerView = Equalizer(count: 1)
        upButton = MetronomeButton()
        downButton = MetronomeButton()
        speedSlider = MetronomeSlider()
        startButton = MetronomeButton()
        beatButton = MetronomeButton()
        pictureButton = MetronomeButton()
        settingsButton = MetronomeButton()
        changeSoundButton = MetronomeButton()
        valueTextField = MetronomeTextField()
        appLabel = MetronomeLabel(text: Constants.appName, font: .ubuntu)
        alertBeat = MetronomeAlert()
        alertPict = MetronomeAlert()
        pictureLabel = MetronomeLabel(text: L10n.picture, font: .roboto)
        beatLabel = MetronomeLabel(text: L10n.size, font: .roboto)
        alertBeat.configure(labelText: L10n.size)
        alertPict.configurePict(labelText: L10n.picture)
        elementSettings()
    }
    
    private func elementSettings() {
        layout()
        speedSlider.configure()
        startButton.configureStartButton()
        startButtonStartConfigure()
        startButtonStopConfigure()
        beatButtonActionConfigure()
        pictureButtonActionConfigure()
        
        startButton.imageInclude(images: imager.path(.play)())
        downButton.setImageToButton(image: imager.path(.down)())
        upButton.setImageToButton(image: imager.path(.up)())
        changeSoundButton.setImageToButton(image: imager.path(.buttonNota)())
        beatButton.litleButtonConfigurate(imageStr: imager.path(.twoFour)())
        settingsButton.setImageToButton(image: imager.path(.setting)())
        pictureButton.litleButtonConfigurate(imageStr: imager.path(.nota)())
        settingsButton.addTarget(self, action: #selector(settingsButtonPress),
                                 for: .touchUpInside)
        speedSlider.addTarget(self, action: #selector(sliderValueDidChange),
                              for: .valueChanged)
        downButton.addTarget(self, action: #selector(downButtonPreess),
                             for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upButtonPreess),
                           for: .touchUpInside)
        changeSoundButton.addTarget(self, action: #selector(changeSoundButtonPress),
                                    for: .touchUpInside)
        valueTextField.addTarget(self, action: #selector(changeValueByTab),
                                 for: .editingDidEndOnExit)
        alertPict.setupImageToButton(firstImage: imager.path(.OneNota)(),
                                     SecondImage: imager.path(.twoNota)(),
                                     thirstImage: imager.path(.nota3)())
    }
    
    @objc func changeValueByTab() { // изменение значений бит метронома по вводу в поле значений
        let val = valueTextField.getInt()
        if val < Constants.minVal {
            speedSlider.value = 20
            valueTextField.text = "20"
            tempo = 20
            ifPlayMertonome()
        } else if val > Constants.maxVal {
            speedSlider.value = Float(Constants.maxVal)
            valueTextField.text = "\(Constants.maxVal)"
            tempo = Int32(Constants.maxVal)
            ifPlayMertonome()
        } else {
            speedSlider.value = Float(val)
            valueTextField.text = "\(val)"
            tempo = Int32(val)
            ifPlayMertonome()
        }
    }
    
    private func layout() { // расположение элементов на вьюхе
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
            make.top.lessThanOrEqualTo(appLabel.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(view.snp.centerX)
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
        
        pageControl.numberOfPages = Int(timeSignature)
        pageControl.currentPage = currentPage
        
        self.view.addSubview(changeSoundButton)
        changeSoundButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(100)
            make.trailing.equalTo(settingsButton.snp.trailing).offset(-50)
        }
        
        self.view.addSubview(beatLabel)
        beatLabel.snp.makeConstraints { make in
            make.width.equalTo(beatButton.snp.width)
            make.height.equalTo(25)
            make.bottom.lessThanOrEqualTo(beatButton.snp.top).offset(-2)
            make.leading.equalTo(beatButton.snp.leading)
            make.top.equalTo(equalizerView.snp.bottom).offset(12)
        }
        
        self.view.addSubview(pictureLabel)
        pictureLabel.snp.makeConstraints { make in
            make.width.equalTo(pictureButton.snp.width)
            make.height.equalTo(25)
            make.bottom.lessThanOrEqualTo(pictureButton.snp.top).offset(-2)
            make.leading.equalTo(pictureButton.snp.leading)
            make.top.equalTo(equalizerView.snp.bottom).offset(12)
        }
    }
    
    //MARK:- UIElements Actions
    
    @objc func changeSoundButtonPress() {// изменение звука метронома
        UIAlertController.getAlert(type: .soundChange) { alert in
            self.present(alert, animated: true, completion: nil)
        } complessionOk: { [self] value in
            switch value {
            case "classic":
                scheme = SoundScheme.path(.classic)()
                changeMelody(scheme: scheme)
            case "triplett":
                scheme = SoundScheme.path(.triplet)()
                changeMelody(scheme: scheme)
            case "cowbell":
                scheme = SoundScheme.path(.other)()
                changeMelody(scheme: scheme)
            case "digital":
                scheme = SoundScheme.path(.digital)()
                changeMelody(scheme: scheme)
            case "digital-Division":
                scheme = SoundScheme.path(.subDevision)()
                changeMelody(scheme: scheme)
            case "digital-Triplet":
                scheme = SoundScheme.path(.triplet)()
                changeMelody(scheme: scheme)
            case "Subdivision":
                scheme = SoundScheme.path(.subDevision)()
                changeMelody(scheme: scheme)
            case "sonarMain":
                scheme = SoundScheme.path(.sonar)()
                changeMelody(scheme: scheme)
            case "abletonMain":
                scheme = SoundScheme.path(.ableton)()
                changeMelody(scheme: scheme)
            case "logicMain":
                scheme = SoundScheme.path(.logic)()
                changeMelody(scheme: scheme)
            case "cubaseMain":
                scheme = SoundScheme.path(.cubase)()
                changeMelody(scheme: scheme)
            default:
                break
            }
        }
    }
    
    private func changeMelody(scheme: UrlSoundModel) {// функция измененния звука метронома по заданной схеме
        metronome = Metronome(urlSoundModel: scheme)
        self.metronome.playMetronome(bpm: self.tempo,
                                     countBeat: self.countBeat,
                                     timeSignature: self.timeSignature)
    }
    
    @objc func downButtonPreess() { // нажатие вниз
        guard tempo > Constants.minVal, tempo < Constants.maxVal - 1 else {return}
        tempo -= 1
        ifPlayMertonome()
        speedSlider.value = Float(tempo)
    }
    
    @objc func upButtonPreess() { // нажатие вверх
        guard tempo > Constants.minVal - 1, tempo < Constants.maxVal  else {return}
        tempo += 1
        ifPlayMertonome()
        speedSlider.value = Float(tempo)
    }
    
    @objc func settingsButtonPress() { // настройки
        MainStart.present(view: self, controller: .settingController)
    }
    
    @objc func sliderValueDidChange() { // изменение положения  слайдера
        tempo = Int32(Int(speedSlider.value))
        print(tempo)
        ifPlayMertonome()
    }
    
    private func beatButtonActionConfigure() { // подьем алерта битов
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
    
    private func pictureButtonActionConfigure() { // подьем алерта картинки
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
    
    private func alertPictConfigure() { // передача комплишнов в кнопку рисунок
        alertPict.complessionFirst = pictOne
        alertPict.complessionSecond = pictTwo
        alertPict.complessionThird = pictThree
    }
    
    private func pictOne() {// рисунок один
        self.alertPict.isHidden = true
        timeSignature = 1
        ifPlayMertonome()
    }
    
    private func pictTwo() { //  рисунок два
        self.alertPict.isHidden = true
        timeSignature = 2
        ifPlayMertonome()
    }
    
    private func pictThree() { // рисунок три
        self.alertPict.isHidden = true
        timeSignature = 4
        ifPlayMertonome()
    }
    
    private func alertConfigure() { // передача комплишнов в кнопку битов
        alertBeat.complessionFirst = beatOne
        alertBeat.complessionSecond = beatTwo
        alertBeat.complessionThird = beatThree
        
    }
    
    private func beatOne() { // бит один
        beatButton.litleButtonConfigurate(imageStr: imager.path(.twoFour)())
        equalizerView.remove()
        pageControl.numberOfPages = Int(2)// pages to pageView
        equalizerView.addVisual(count: 2) // обработка эквалайзера
        countBeat = 2
        self.alertPict.isHidden = true
        ifPlayMertonome()
    }
    
    private func beatTwo() {// бит два
        beatButton.litleButtonConfigurate(imageStr: imager.path(.threefour)())
        equalizerView.remove()
        pageControl.numberOfPages = Int(3)// pages to pageView
        equalizerView.addVisual(count: 3)// обработка эквалайзера
        countBeat = 3
        self.alertPict.isHidden = true
        ifPlayMertonome()
    }
    
    private func beatThree() { // бит три
        beatButton.litleButtonConfigurate(imageStr: imager.path(.fourFour)())
        equalizerView.remove()
        pageControl.numberOfPages = Int(4)// pages to pageView
        equalizerView.addVisual(count: 4)// обработка эквалайзера
        countBeat = 4
        self.alertPict.isHidden = true
        ifPlayMertonome()
    }
    
    //MARK:-  View
    override func viewDidLoad() {
        super.viewDidLoad()
        scheme = SoundScheme.path(.classic)()
        metronome = Metronome(urlSoundModel: scheme)
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
    
    //MARK:- Start-Stop Timer Configure
    
    private func startButtonStartConfigure() {
        startButton.startConfigure {
            self.metronome.stopMetranome()
        }
    }
    
    private func startButtonStopConfigure() {
        startButton.stopConfigure {
            self.metronome.playMetronome(bpm: self.tempo,
                                         countBeat: self.countBeat,
                                         timeSignature: self.timeSignature)
        }
    }
    
    func ifPlayMertonome() {
        if metronome.isPlay {
            metronome.stopMetranome()
            metronome.playMetronome(bpm: tempo,
                                    countBeat: countBeat,
                                    timeSignature: timeSignature)
        }
    }
    
    
}
