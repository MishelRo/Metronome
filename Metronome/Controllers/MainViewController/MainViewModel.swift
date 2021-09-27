//
//  MainViewModel.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

protocol TickDelegate {
    func tick(count: Int)
}

protocol MainViewModelProtocol {
    var audioPlayer: SoundPlayer? {get set}
    func animate(bpm: Int)
    func timerReturn(timeInterval: Double, bpm: Double ) -> Timer
    func bit(value: String) -> SoundPlayer?
    var tick: Int {get set}
    var delegate: TickDelegate!{get set}
}

import UIKit
import AVFoundation

class MainViewModel: MainViewModelProtocol {
    
    var audioPlayer: SoundPlayer?
    var delegate: TickDelegate!
    var tick = 0
    
    @objc func newValueTick(bpm: Int) {
        UIView.animate(withDuration:  Double.getDouble(intOne: 60, intTwo: bpm), animations: {
            self.audioPlayer?.audioPlayback(complessionTick: {
                self.tick += 1
                self.delegate.tick(count: self.tick)
            }) {
                self.tick += 1
                self.delegate.tick(count: self.tick)
            }
        })
    }
    
    func timerReturn(timeInterval: Double, bpm: Double ) -> Timer {
        let  timer = Timer.scheduledTimer(timeInterval: timeInterval / bpm, target: self,
                                          selector: #selector(self.newValueTick), userInfo: nil, repeats: true)
        return timer
    }
    
    func animate(bpm: Int) {
        UIView.animate(withDuration: Double.getDouble(intOne: 60, intTwo: bpm), animations: {
        })
    }
    
    func bit(value: String) -> SoundPlayer? {
        switch value {
        case "standart":
            return SoundPlayer(model: .standart)
        case "light":
            return SoundPlayer(model: .light)
        case "custom":
            return SoundPlayer(model: .custom)
        case "other":
            return SoundPlayer(model: .other)
        case "digital":
            return SoundPlayer(model: .digital)
        case "triplet":
            return SoundPlayer(model: .triplet)
        case "subDevision":
            return SoundPlayer(model: .subDevision)
        default: break
        }
        return nil
    }
}
