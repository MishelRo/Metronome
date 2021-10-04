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
    var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        start()
        stop()
        uIConfigure()
        layout()
    }
    
    
    func uIConfigure() {
        backButton = UIButton()
    }
    
    func layout() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.setImage(imager.path(.back)(), for: .normal)
    }
    
    @objc func back() {
        navigationController?.pushViewController(MainStart.getController(controller: .mainViewController), animated: false)
    }
    
    func start() {
        startAnimation(delay: 0.04, replication: 100)
    }
    
    func stop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.7, qos: .default, flags: .barrier) {
            self.replicatorLayer.removeFromSuperlayer()
        }
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
