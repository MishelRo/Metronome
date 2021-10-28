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
    var oneTabNoteFirstBlockComplession: (()->())!
    var twoTabNoteFirstBlockComplession: (()->())!
    var threeTabNoteFirstBlockComplession: (()->())!
    var arrayOfView = [UIView]()
    
    var firstView: UIView!
    var secondView: UIView!
    var thirdView: UIView!
    var fourView: UIView!
    
    func configureoneTabNoteFirstBlockComplession(action: @escaping (()->())) { // обнвление действия по нажатию первого элемента
        oneTabNoteFirstBlockComplession = action
    }
    func configureTwoTabNoteFirstBlockComplession(action: @escaping (()->())) { // обнвление действия по нажатию первого элемента
        twoTabNoteFirstBlockComplession = action
    }
    func configureDoubleTabNoteFirstBlockComplession(action: @escaping (()->())) { // обнвление действия по нажатию первого элемента
        threeTabNoteFirstBlockComplession = action
    }
    
    func configure() {
        stackView = UIStackView()
        backgroundColor = Constants.MainBackgroundColor
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
            make.center.equalTo(self.snp.center)
        }
    }
    
    
    func flashAnimate(countOfElement: Int, pictureCount: Int) {
        firstView.layer.cornerRadius = 5
        secondView.layer.cornerRadius = 5
        thirdView.layer.cornerRadius = 5
        fourView.layer.cornerRadius = 5

        switch pictureCount {
        case 1:
            switch countOfElement { // 1 elements
            case 1:
                firstView.getFlash()
            case 2:
                secondView.getFlash()
            case 3:
                thirdView.getFlash()
            case 4:
                fourView.getFlash()
            default:
                break
            }
        case 2:
            switch countOfElement {// 2 elements
            case 1:
                firstView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.firstView.getFlash()
                }
            case 2:
                secondView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.secondView.getFlash()
                }
            case 3:
                thirdView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.thirdView.getFlash()
                }
            case 4:
                fourView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.fourView.getFlash()
                }
            default:
                break
            }
        case 4:
            switch countOfElement {// 2 elements
            case 1:
                firstView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.firstView.getFlash()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        self.firstView.getFlash()
                    }
                }
            case 2:
                secondView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.secondView.getFlash()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        self.secondView.getFlash()
                    }
                }
            case 3:
                thirdView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.thirdView.getFlash()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        self.thirdView.getFlash()
                    }
                }
            case 4:
                fourView.getFlash()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.fourView.getFlash()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        self.fourView.getFlash()
                    }
                }
            default:
                break
            }
        default: break
        }
    }
    
    func configureEq() {
        firstView = StackViewCel.make(oneTabComplession: oneTabNoteFirstBlock, unselected: unselectedAllFirstBlock, doubleTabComplessionSelected: doubleTabFirstBlock, doubleTabComplessionUnSelected: downNoteTabFirstBlock)
        
        secondView = StackViewCel.make(oneTabComplession: oneTabNoteSecondBlock, unselected: unselectedAllSecondBlock, doubleTabComplessionSelected: doubleTabSecondBlock, doubleTabComplessionUnSelected: downNoteTabSecondBlock)
        
        thirdView = StackViewCel.make(oneTabComplession: oneTabNoteThirdNote, unselected: unselectedAllThirdNote, doubleTabComplessionSelected: doubleTabThirdNote, doubleTabComplessionUnSelected: downNoteTabThirdNote)
        
        fourView = StackViewCel.make(oneTabComplession: oneTabNoteFourNote, unselected: unselectedAllFourNote, doubleTabComplessionSelected: doubleTabFourNote, doubleTabComplessionUnSelected: downNoteTabFourNote)
    }
    
    func addVisual(count: Int) {
        configureEq()
        switch count {
        case 1:
            arrayOfView.append(firstView)
        case 2:
            arrayOfView = [UIView]()
            arrayOfView.append(firstView)
            arrayOfView.append(secondView)
        case 3:
            arrayOfView = [UIView]()
            arrayOfView.append(firstView)
            arrayOfView.append(secondView)
            arrayOfView.append(thirdView)
        case 4:
            arrayOfView = [UIView]()
            arrayOfView.append(firstView)
            arrayOfView.append(secondView)
            arrayOfView.append(thirdView)
            arrayOfView.append(fourView)
        default: break
        }
        backgroundColor = Constants.MainBackgroundColor
        for item in arrayOfView {
            [ item ].forEach { stackView.addArrangedSubview($0)}
        }
    }
    
    //MARK:- firstNote
    func oneTabNoteFirstBlock() {
        oneTabNoteFirstBlockComplession()
        print("oneTabNoteFirstBlock")
    }
    func unselectedAllFirstBlock() {
        threeTabNoteFirstBlockComplession()
        print("unselectedAllFirstBlock")
    }
    func doubleTabFirstBlock() {
        twoTabNoteFirstBlockComplession()
        print("doubleTabFirstBlock")
    }
    func downNoteTabFirstBlock() {
        print("downNoteTabFirstBlock")
    }
    //MARK:- SecondNote
    func oneTabNoteSecondBlock() {
        print("oneTabNoteSecondBlock")
    }
    func unselectedAllSecondBlock() {
        print("unselectedAllSecondBlock")
    }
    func doubleTabSecondBlock() {
        print("doubleTabSecondBlock")
    }
    func downNoteTabSecondBlock() {
        print("downNoteTabSecondBlock")
    }
    //MARK:- ThirdNote
    func oneTabNoteThirdNote() {
        print("oneTabNoteThirdNote")
    }
    func unselectedAllThirdNote() {
        print("unselectedAllThirdNote")
    }
    func doubleTabThirdNote() {
        print("doubleTabThirdNote")
    }
    func downNoteTabThirdNote() {
        print("downNoteTabThirdNote")
    }
    //MARK:- FourNote
    func oneTabNoteFourNote() {
        print("oneTabNoteFourNote")
    }
    func unselectedAllFourNote() {
        print("unselectedAllFourNote")
    }
    func doubleTabFourNote() {
        print("doubleTabFourNote")
    }
    func downNoteTabFourNote() {
        print("downNoteTabFourNote")
    }
    func remove() {
        stackView.removeSubviews()
    }
    func currentfraction(fraction: Int) {
        print(fraction)
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


