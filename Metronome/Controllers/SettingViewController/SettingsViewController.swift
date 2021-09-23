//
//  SettingsViewController.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var model: SettingViewModelProtocol {
        return SettingViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
    }

}
