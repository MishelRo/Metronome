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
    var audioPlayer: SoundPlayer {get set}
    func animate(bpm: Int)
    func timerReturn(timeInterval: Double, bpm: Double ) -> Timer
    var tick: Int {get set}
    var delegate: TickDelegate!{get set}
}

import UIKit
import AVFoundation

class MainViewModel: MainViewModelProtocol {
    
    var audioPlayer = SoundPlayer.shared
    var tick = 0
    
    var delegate: TickDelegate!
    
    @objc func newValueTick(bpm: Int) {
        UIView.animate(withDuration:  Double.getDouble(intOne: 60, intTwo: bpm), animations: {
            self.audioPlayer.audioPlayback(complessionTick: {
                print("tick")
                self.tick += 1
                self.delegate.tick(count: self.tick)
            }) {
                print("tock")
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
}
