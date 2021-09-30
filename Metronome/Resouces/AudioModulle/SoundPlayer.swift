//
//  SoundPlayer.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import AVFoundation

enum SoundScheme { // энум с кейсами названий аудио схем
    case standart
    case light
    case custom
    case other
    case digital
    case triplet
    case subDevision
}

extension SoundScheme {
    func path () -> UrlSoundModel { // возвращает выбранную в энуме схему
        switch self {
        case .standart:
            let scheme = mp4aSounSchemeConfigure(hightSound: "Low", lowSound: "Hight")
            return scheme!
        case .light:
            let scheme = wavSounSchemeConfigure(hightSound: "Triplet", lowSound: "Beat")
            return scheme!
        case .custom:
            let scheme = wavSounSchemeConfigure(hightSound: "cowbell", lowSound: "cowbellaccent")
            return scheme!
        case .other:
            let scheme = wavSounSchemeConfigure(hightSound: "digital-Accent", lowSound: "digital-Beat")
            return scheme!
        case .digital:
            let scheme = wavSounSchemeConfigure(hightSound: "digital-Division", lowSound: "digital-Subdivision")
            return scheme!
        case .triplet:
            let scheme = wavSounSchemeConfigure(hightSound: "digital-Triplet", lowSound: "Division")
            return scheme!
        case .subDevision:
            let scheme = wavSounSchemeConfigure(hightSound: "Subdivision", lowSound: "Triplet")
            return scheme!
        }
    }
    
    func wavSounSchemeConfigure(hightSound: String, lowSound: String) -> UrlSoundModel? { // реализация звуков WAV
        guard let tickUrl = Bundle.main.url(forResource: hightSound, withExtension: "wav"),
              let tockUrl = Bundle.main.url(forResource: lowSound, withExtension: "wav") else {
            print("Fail")
            return  nil}
        let urlScheme = UrlSoundModel(lowSound: tickUrl, hightSound: tockUrl)
        return urlScheme
    }
    
    func mp4aSounSchemeConfigure(hightSound: String, lowSound: String) -> UrlSoundModel? { // реализация звуков M4A
        guard let tickUrl = Bundle.main.url(forResource: hightSound, withExtension: "m4a"),
              let tockUrl = Bundle.main.url(forResource: lowSound, withExtension: "m4a") else {
            print("Fail")
            return  nil}
        let urlScheme = UrlSoundModel(lowSound: tickUrl, hightSound: tockUrl)
        return urlScheme
    }
}



final class SoundPlayer {
    
    var tockNote: AVAudioPlayer?
    var tickNote: AVAudioPlayer?
    private var count = 1
    private var beat = 1
    
    func changeBeats(beats: Int) { // функция добавления частоты ударов
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
    
    init(model: SoundScheme) { // инициализатор с переключателем схем
        switch model {
        case .standart:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .light:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .custom:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .other:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .digital:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .triplet:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        case .subDevision:
            let tickUrl = model.path().hightSound
            let tockUrl = model.path().lowSound
            do {
                tickNote = try AVAudioPlayer(contentsOf: tickUrl)
                tockNote = try AVAudioPlayer(contentsOf: tockUrl)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
