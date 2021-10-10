//
//  SoundSchemeCreator.swift
//  Metronome
//
//  Created by User on 02.10.2021.
//
enum note {
    case Height
    case Low
    case HightLow
}

import Foundation
class SoundSchemeCreator {

    func createScheme (currentScheme: SoundScheme, note: note) -> UrlSoundModel {
        switch currentScheme {
        
        case .light:
            switch note {
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Beat", lowSound: "Beat")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Triplet", lowSound: "Triplet")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Triplet", lowSound: "Beat")
                return scheme!
            }
        case .custom:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "cowbell", lowSound: "cowbell")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "cowbellaccent", lowSound: "cowbellaccent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "cowbell", lowSound: "cowbellaccent")
                return scheme!
            }
        case .other:
            switch note {
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Accent", lowSound: "digital-Accent")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Beat", lowSound: "digital-Beat")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Accent", lowSound: "digital-Beat")
                return scheme!
            }
        case .digital:
            switch note {
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Division", lowSound: "digital-Division")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Subdivision", lowSound: "digital-Subdivision")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Division", lowSound: "digital-Subdivision")
                return scheme!
            }
        case .triplet:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Triplet", lowSound: "digital-Triplet")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Division", lowSound: "Division")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "digital-Triplet", lowSound: "Division")
                return scheme!
            }
        case .subDevision:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Subdivision", lowSound: "Subdivision")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Triplet", lowSound: "Triplet")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Subdivision", lowSound: "Triplet")
                return scheme!
            }
        case .sonar:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Sonar_main", lowSound: "Sonar_main")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Sonar_accent", lowSound: "Sonar_accent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Sonar_main", lowSound: "Sonar_accent")
                return scheme!
            }
        case .classic:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Classic_main", lowSound: "Classic_main")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Classic_accent", lowSound: "Classic_accent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Classic_main", lowSound: "Classic_accent")
                return scheme!
            }
        case .ableton:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Ableton_main", lowSound: "Ableton_main")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Ableton_accent", lowSound: "Ableton_accent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Ableton_main", lowSound: "Ableton_accent")
                return scheme!
            }
        case .logic:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Logic_main", lowSound: "Logic_main")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Logic_accent", lowSound: "Logic_accent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Logic_main", lowSound: "Logic_accent")
                return scheme!
            }
        case .cubase:
            switch note {
            
            case .Height:
                let scheme = wavSounSchemeConfigure(hightSound: "Cubase_main", lowSound: "Cubase_main")
                return scheme!
            case .Low:
                let scheme = wavSounSchemeConfigure(hightSound: "Cubase_accent", lowSound: "Cubase_accent")
                return scheme!
            case .HightLow:
                let scheme = wavSounSchemeConfigure(hightSound: "Cubase_main", lowSound: "Cubase_accent")
                return scheme!
            }
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
