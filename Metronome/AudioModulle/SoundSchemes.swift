//
//  SoundPlayer.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import AVFoundation

enum SoundScheme { // энум с кейсами названий аудио схем
    case light
    case custom
    case other
    case digital
    case triplet
    case subDevision
    case sonar
    case classic
    case ableton
    case logic
    case cubase
}

extension SoundScheme {
    func path () -> UrlSoundModel { // возвращает выбранную в энуме схему
        switch self {
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
        case .sonar:
            let scheme = wavSounSchemeConfigure(hightSound: "Sonar_main", lowSound: "Sonar_accent")
            return scheme!
        case .classic:
            let scheme = wavSounSchemeConfigure(hightSound: "Classic_main", lowSound: "Classic_accent") //ok
            return scheme!
        case .ableton:
            let scheme = wavSounSchemeConfigure(hightSound: "Ableton_main", lowSound: "Ableton_accent")
            return scheme!
        case .logic:
            let scheme = wavSounSchemeConfigure(hightSound: "Logic_main", lowSound: "Logic_accent")
            return scheme!
        case .cubase:
            let scheme = wavSounSchemeConfigure(hightSound: "Cubase_main", lowSound: "Cubase_accent")
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

