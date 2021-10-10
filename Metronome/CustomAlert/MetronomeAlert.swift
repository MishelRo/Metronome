//
//  CustomAlert.swift
//  Metronome
//
//  Created by User on 28.09.2021.
//

import UIKit
import SnapKit

class MetronomeAlert: UIView {

    var label: UILabel!
    var firstButton: UIButton!
    var secondButton: UIButton!
    var thirdButton: UIButton!
    var lineView: UIView!
    var pickerView: UIPickerView!
    var pickViewContentView: UIView!
    var includeLabel: UILabel!
    
    var complessionFirst: (()->())!  // действие первого элемента
    var complessionSecond: (()->())! // действие второго элемента
    var complessionThird: (()->())!  // действие третьего элемента
    
    var selectRow = 0 // выбранная ячейка picker view
    var selectedBit = 0 // выбранная частота
    var numbers = ["2","3","4"] // массив с элементами частоты
    
    //MARK:- Beat Allert Configuration
    func configure(labelText: String) {
        label = UILabel()
        lineView = UIView()
        includeLabel = UILabel()
        firstButton = UIButton()
        thirdButton = UIButton()
        secondButton = UIButton()
        pickerView = UIPickerView()
        pickViewContentView = UIView()
        pickerView.delegate = self
        includeLabel.font = UIFont(name: "Ubuntu", size: 22)
        layout(text: labelText)
    }
    
    func layout(text: String) {
        addSubview(label)
        label.textAlignment = .center
        label.text = text
        label.textColor = .white
        includeLabel.font = UIFont(name: "Roboto", size: 24)
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(58)
        }
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            lineView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            make.top.equalTo(label.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.width.equalTo(label.snp.width)
        }
        addSubview(pickViewContentView)
        pickViewContentView.layer.cornerRadius = 10
        pickViewContentView.snp.makeConstraints { make in
            make.width.equalTo(snp.width).offset(-20)
            make.height.equalTo(35)
            make.centerY.equalTo(snp.centerY).offset(30)
            make.centerX.equalTo(snp.centerX)
        }
        pickViewContentView.addSubview(includeLabel)
        includeLabel.text = "/    4"
        includeLabel.font = UIFont(name: "Roboto", size: 24)
        includeLabel.textColor = #colorLiteral(red: 0.8078379035, green: 0.8077895045, blue: 0.8120592237, alpha: 1)
        includeLabel.snp.makeConstraints { make in
            make.leading.equalTo(pickViewContentView.snp.centerX)
            make.top.equalTo(pickViewContentView.snp.top).offset(-2)
            make.bottom.equalTo(pickViewContentView.snp.bottom)
            make.trailing.equalTo(pickViewContentView.snp.trailing).offset(-20)
        }
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(120)
            make.top.equalTo(lineView.snp.bottom).offset(-2)
            make.bottom.equalTo(snp.bottom).offset(-2)
            make.trailing.equalTo(snp.centerX).offset(-10)
        }
    }
    //MARK:- PictAllert Configuration

    func configurePict(labelText: String) {
        label = UILabel()
        includeLabel = UILabel()
        includeLabel.font = UIFont(name: "Ubuntu", size: 22)
        pickViewContentView = UIView()
        firstButton = UIButton()
        secondButton = UIButton()
        thirdButton = UIButton()
        lineView = UIView()
        pickerView = UIPickerView()
        layoutPict(text: labelText)
    }
        func layoutPict(text: String) {
        addSubview(label)
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        includeLabel.font = UIFont(name: "Roboto", size: 24)
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.height.equalTo(58)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            lineView.backgroundColor = .white
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
            make.width.equalTo(firstButton.snp.width).offset(-35)
            make.centerX.equalTo(snp.centerX)
        }
        addSubview(thirdButton)
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(secondButton.snp.bottom).offset(15)
            make.height.equalTo(secondButton.snp.height)
            make.width.equalTo(firstButton.snp.width)
            make.centerX.equalTo(snp.centerX)
        }
        self.firstButton.addTarget(self, action: #selector(firstButtonTabConfigure), for: .touchUpInside)
        self.secondButton.addTarget(self, action: #selector(secondButtonTabConfigure), for: .touchUpInside)
        self.thirdButton.addTarget(self, action: #selector(thirdButtonTabConfigure), for: .touchUpInside)
    }

    //MARK:- TabElement
 
    @objc func firstButtonTabConfigure() {
        complessionFirst()
    }
    
    @objc func secondButtonTabConfigure() {
        complessionSecond()
    }
    
    @objc func thirdButtonTabConfigure() {
        complessionThird()
    }
    
    func setupImageToButton(firstImage: UIImage,
                            SecondImage: UIImage,
                            thirstImage: UIImage) {
        firstButton.setImage(firstImage, for: .normal)
        secondButton.setImage(SecondImage, for: .normal)
        thirdButton.setImage(thirstImage, for: .normal)
    }
    //MARK:- init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.allertColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- PickerView Delegate Implementation

extension MetronomeAlert: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
       return numbers.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        var label = UILabel()
        if pickerView.selectedRow(inComponent: component) == row {
                    if let v = view as? UILabel { label = v }
                    label.font = UIFont(name: "Roboto", size: 24)
                    label.textAlignment = .left
                    label.text =  numbers[row]
                    label.textColor = .white
                    label.textAlignment = .center
                    return label
            } else {
                if let v = view as? UILabel { label = v }
                label.font = UIFont(name: "Roboto", size: 24)
                label.textAlignment = .left
                label.text =  numbers[row]
                label.textColor = .black
                label.textAlignment = .center
                return label
            }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return numbers[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        selectRow = row
        switch selectRow {
        case 0:
            complessionFirst()
        case 1:
            complessionSecond()
        case 2:
            complessionThird()
        default:
            break
        }
        pickerView.reloadAllComponents()

    }

}
