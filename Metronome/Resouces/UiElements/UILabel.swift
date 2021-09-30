//
//  UILabel.swift
//  Metronome
//
//  Created by User on 29.09.2021.
//

enum texts {
    case standart
    case ubuntu
    case roboto
}

extension texts {
    func path() -> UIFont{
        switch self {
        case .standart:
            return UIFont(name: "Standart", size: 14)!
        case .ubuntu:
            return UIFont(name: "Ubuntu", size: 23)!
        case .roboto:
            return UIFont(name: "Roboto", size: 14)!
        }
    }
}

import UIKit

class MetronomeLabel: UILabel {
    init(text: String, font: texts) {
        super.init(frame: .zero)
        self.text = text
        self.font = font.path()
        textColor = .white
        textAlignment = .center

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
