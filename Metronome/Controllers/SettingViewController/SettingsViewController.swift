//
//  SettingsViewController.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    
    var model: SettingViewModelProtocol {
        return SettingViewModel()
    }
    var replicatorLayer : CAReplicatorLayer!
    var sourceLayer : CALayer!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        startAnimation(delay: 0.01, replication: 100)
    }
    
    
    override func viewWillLayoutSubviews() {
        replicatorLayer.frame = self.view.bounds
        replicatorLayer.position = self.view.center
        sourceLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 259)
        sourceLayer.backgroundColor = UIColor.white.cgColor
        sourceLayer.position = self.view.center
        sourceLayer.anchorPoint = CGPoint(x: 2, y: 0.5)
    }
    
    func startAnimation(delay: TimeInterval, replication: Int){
        replicatorLayer.instanceCount = replication
        let angle = CGFloat(2.0 * .pi) / CGFloat(replication)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 5, 3)
        replicatorLayer.instanceDelay = delay
        sourceLayer.opacity = 0
        let opacityAnimasion = CABasicAnimation(keyPath: "opacity")
        opacityAnimasion.fromValue = 1
        opacityAnimasion.toValue = 0
        opacityAnimasion.duration = Double(replication) * delay
        opacityAnimasion.repeatCount = Float.infinity
        sourceLayer.add(opacityAnimasion, forKey: nil)
    }
}
