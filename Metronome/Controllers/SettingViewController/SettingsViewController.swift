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
    var switchButton: UISwitch!
    var label: UILabel!
    var image: UIImageView! {
        didSet {
            image.layer.cornerRadius = 40
            image.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MainBackgroundColor
        image = UIImageView()
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        start()
        stop()
        uIConfigure()
        layout()
        switchButton.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        sliderDefault()
    }
  

    func sliderDefault() {
        if UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle == .dark {
            switchButton.setOn(UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle == .dark, animated: true)
            self.replicatorLayer.removeFromSuperlayer()
            view.addSubview(image)
            image.snp.makeConstraints { make in
                make.center.equalTo(view.center)
                make.height.equalTo(view.frame.height / 4)
                make.width.equalTo(view.snp.width).offset( -20)
            }
            image.backgroundColor = .red
            image.image = UIImage(named: "blackTheme")
        }
    }
    
    
    
    
    @objc func switchValueDidChange() {
        if switchButton.isOn {
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .dark
            self.replicatorLayer.removeFromSuperlayer()
            view.addSubview(image)
            image.snp.makeConstraints { make in
                make.center.equalTo(view.center)
                make.height.equalTo(view.frame.height / 4)
                make.width.equalTo(view.snp.width).offset( -20)
            }
            self.image.alpha = 0
            self.image.layer.cornerRadius = 500
            image.isHidden = false
            image.backgroundColor = .red
            image.image = UIImage(named: "blackTheme")
            UIView.animate(withDuration: 3 , delay: 0, animations: {
                self.image.alpha = 1
                self.image.layer.cornerRadius = 20

            })
        } else {
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
            UIView.animate(withDuration: 3 , delay: 0, animations: {
                self.image.alpha = 0.2
                self.image.layer.cornerRadius = 500
            })
        }
    }
    
    
    
    
    
    func uIConfigure() {
        backButton = UIButton()
        switchButton = UISwitch()
        label = UILabel()
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
        view.addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
        view.addSubview(label)
        label.text = "Темная тема"
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(40)
        }
        
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
