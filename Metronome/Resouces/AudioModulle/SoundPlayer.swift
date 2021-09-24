//
//  SoundPlayer.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import AVFoundation

final class SoundPlayer {
    
static var shared = SoundPlayer()
    var tockNote: AVAudioPlayer?
    var tickNote: AVAudioPlayer?
    private var count = 1
    private var beat = 1
    
    func changeBeats(beats: Int) {
        self.beat = beats
        count = 1
    }
    
    func audioPlayback(complessionTick: @escaping()->(), complessionTock: @escaping()->()) {
        if let tick = tickNote, let tock = tockNote {
            if count == 1 {
                tick.play()
                complessionTick()
            } else {
                tock.play()
                complessionTock()
            }
            if count < beat {
                count += 1
            } else {
                count = 1
            }
        }
    }
    
    private init() {
        guard let tickUrl = Bundle.main.url(forResource: "Hight", withExtension: "m4a"),
              let tockUrl = Bundle.main.url(forResource: "Low", withExtension: "m4a") else {
            print("Fail")
            return}
        do {
            tickNote = try AVAudioPlayer(contentsOf: tickUrl)
            tockNote = try AVAudioPlayer(contentsOf: tockUrl)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
