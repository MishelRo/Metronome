//
//  SceneDelegate.swift
//  Metronome
//
//  Created by User on 22.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let WS = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: WS.coordinateSpace.bounds)
        window?.windowScene = WS
        window?.rootViewController = MainStart.getNCController(controller: .mainViewController)
        window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

