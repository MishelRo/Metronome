//
//  MainStart.swift
//  Metronome
//
//  Created by User on 22.09.2021.
//
import UIKit

enum returnVC {
    case mainViewController
    case settingController
    case registerViewController
  
}

extension returnVC {
    func path()-> UIViewController{
        switch self {
        case .mainViewController:
            return MainViewController()
        case .settingController:
            return SettingsViewController()
        case .registerViewController:
            return RegisterViewController()
        }
    }
}

class MainStart {
    
    static func getNCController(controller: returnVC) -> UINavigationController {
        UINavigationController(rootViewController: controller.path())
    }
    static func getController(controller: returnVC) -> UIViewController {
        controller.path()
    }
    static func present(view: UIViewController, controller: returnVC) {
        view.navigationController?.pushViewController(controller.path(), animated: true)
    }
   
}
