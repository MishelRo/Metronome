//
//  ImageNameReturner.swift
//  Metronome
//
//  Created by User on 28.09.2021.
//

import UIKit
enum imager {
    case beatButton
    case buttonNota
    case currentCell
    case down
    case nota
    case nota3
    case OneNota
    case pause
    case play
    case seek
    case selectedCell
    case setting
    case twoNota
    case unSelected
    case up
    case newTwoButton
    case twoFour
    case threefour
    case fourFour
    case selected
    case unselected
}

extension imager {
    func path() -> UIImage {
        switch self {
        case .beatButton:
            return UIImage(named: "24")!
        case .buttonNota:
            return UIImage(named: "buttonNota")!
        case .currentCell:
            return UIImage(named: "currentCell")!
        case .down:
            return UIImage(named: "down")!
        case .nota:
            return UIImage(named: "Nota")!
        case .nota3:
            return UIImage(named: "nota3")!
        case .OneNota:
            return UIImage(named: "OneNota")!
        case .pause:
            return UIImage(named: "pause")!
        case .play:
            return UIImage(named: "play")!
        case .seek:
            return UIImage(named: "seek")!
        case .selectedCell:
            return UIImage(named: "selectedCell")!
        case .setting:
            return UIImage(named: "Settings")!
        case .twoNota:
            return UIImage(named: "twoNota")!
        case .unSelected:
            return UIImage(named: "unSelected")!
        case .up:
            return UIImage(named: "up")!
        case .twoFour:
            return UIImage(named: "24")!
        case .newTwoButton:
            return UIImage(named: "newTwoButton")!
        case .threefour:
            return UIImage(named: "34")!
        case .fourFour:
            return UIImage(named: "44")!
        case .selected:
            return UIImage(named: "selectedCell")!
        case .unselected:
            return UIImage(named: "unSelected")!
        }
    }
}
