//
//  SettingsViewController.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import UIKit
import SnapKit
import KeychainSwift

class SettingsViewController: UIViewController {
    
    var model: SettingViewModelProtocol {
        return SettingViewModel()
    }
    var replicatorLayer : CAReplicatorLayer!
    var sourceLayer : CALayer!
    var backButton: UIButton!
    var switchButton: UISwitch!
    var label: UILabel!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var register: UIImageView!
    var lineView: UIView!
    var secondlineView: UIView!
    var textLabel: UILabel!
    var keyChain: KeychainSwift!
    var buttonUnlog: UIButton!
    var authLabel: UILabel!
    
    var avatarUserImage: UIImageView! {
        didSet {
            avatarUserImage.layer.cornerRadius = 60
            avatarUserImage.clipsToBounds = true
            avatarUserImage.image = UIImage(named: "woman")
            CoreDataManager().getData { dataImage in
                guard  let _ = self.keyChain.get("name") else {return}
                guard let image = UIImage(data: dataImage) else {
                    self.avatarUserImage.image = UIImage(named: "woman"); return
                }
                self.avatarUserImage.image = image
            } errorData: {
                self.avatarUserImage.image = UIImage(named: "woman")
            }

        }
    }
    
    var image: UIImageView! {
        didSet {
            image.layer.cornerRadius = 40
            image.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        keyChain = KeychainSwift()
        view.backgroundColor = Constants.MainBackgroundColor
        authLabel = UILabel()
        lineView = UIView()
        buttonUnlog = UIButton()
        secondlineView = UIView()
        image = UIImageView()
        register = UIImageView()
        avatarUserImage = UIImageView()
        uIConfigure()
        layout()
        switchButton.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        sliderDefault()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        register.addGestureRecognizer(tap)
        register.isUserInteractionEnabled = true
        getData()
        let tapByAvatar = UITapGestureRecognizer(target: self, action: #selector(self.setImage(_:)))
        avatarUserImage.addGestureRecognizer(tapByAvatar)
        avatarUserImage.isUserInteractionEnabled = true
        avatarUserImage.contentMode = .scaleAspectFill
        guard  let _ = self.keyChain.get("name") else {return}
        self.authLabel.isHidden = true
        guard let email = keyChain.get("email")  else {return}
        }
  
    
   
  
   @objc  func setImage(_ sender: UITapGestureRecognizer) {
       guard  let _ = self.keyChain.get("name") else {return}
        let provider = CameraProvider(delegate: self)

        do {
            let picker = try provider.getImagePicker(source: .photoLibrary)
            present(picker, animated: true)
        } catch {
            NSLog("Error: \(error.localizedDescription)")
        }
    }
    
    
    
    func getData() {
        buttonUnlog.isHidden = true
        if keyChain.getBool("Auth") ?? false {
            guard  let name = keyChain.get("name") else {return}
            guard let secondName = keyChain.get("secondName")  else {return}
            guard let email = keyChain.get("email")  else {return}
            nameLabel.text =  name + " " + secondName
            emailLabel.text = email
            register.isHidden = true
            buttonUnlog.isHidden = false

        }

    }

    func sliderDefault() {
        if UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle == .dark {
            switchButton.setOn(UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle == .dark, animated: true)
            view.addSubview(image)
            image.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY).offset(100)
                make.height.equalTo(view.frame.height / 4)
                make.width.equalTo(view.snp.width).offset( -20)
            }
            image.backgroundColor = .red
            image.image = UIImage(named: "blackTheme")
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        MainStart.present(view: self, controller: .registerViewController)
    }
    
    @objc func switchValueDidChange() {
        if switchButton.isOn {
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .dark
            self.label.text = "Темная тема"
            view.addSubview(image)
            image.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY).offset(100)
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
            self.label.text = "Светлая тема"
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
            UIView.animate(withDuration: 3 , delay: 0, animations: {
                self.image.alpha = 0.2
                self.image.layer.cornerRadius = 0
                self.image.alpha = 0
                self.image.isHidden = false
                self.image.backgroundColor = .red
                self.image.image = UIImage(named: "whiteTheme")
                UIView.animate(withDuration: 3 , delay: 0, animations: {
                    self.image.alpha = 1
                    self.image.layer.cornerRadius = 20

                })
            })
        }
    }
    
    func uIConfigure() {
        textLabel = UILabel()
        backButton = UIButton()
        switchButton = UISwitch()
        label = UILabel()
        nameLabel = UILabel()
        emailLabel = UILabel()
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(233)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        view.addSubview(label)
        label.text = "Темная тема"
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(230)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(40)
        }
        view.addSubview(avatarUserImage)
        avatarUserImage.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        view.addSubview(nameLabel)
        nameLabel.text = "Имя и Фамилия"
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalTo(avatarUserImage.snp.trailing).offset(20)
            
        }
        view.addSubview(emailLabel)
        emailLabel.text = "Почта"
        emailLabel.textColor = .white
        emailLabel.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(avatarUserImage.snp.trailing).offset(20)
        }
        
        view.addSubview(buttonUnlog)
        buttonUnlog.setTitle("Выйти", for: .normal)
        buttonUnlog.addTarget(self, action: #selector(unlog), for: .touchUpInside)
        buttonUnlog.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalTo(avatarUserImage.snp.trailing).offset(20)
            make.bottom.equalTo(avatarUserImage.snp.bottom)
        }
        
        view.addSubview(register)
        register.image = UIImage(named: "regButton")
        register.snp.makeConstraints { make in
            make.width.equalTo( 19.5)
            make.height.equalTo( 36.4)
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.trailing).offset(30)
        }
        view.addSubview(lineView)
        lineView.backgroundColor = .lightGray
        lineView.snp.makeConstraints { make in
            make.width.equalTo(view.width)
            make.height.equalTo(1)
            make.top.equalTo(avatarUserImage.snp.bottom).offset(10)
            
        }
        
        view.addSubview(secondlineView)
        secondlineView.backgroundColor = .lightGray
        secondlineView.snp.makeConstraints { make in
            make.width.equalTo(view.width)
            make.height.equalTo(1)
            make.top.equalTo(switchButton.snp.bottom).offset(20)
        }
        view.addSubview(textLabel)
        textLabel.text = "Тема"
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        view.addSubview(authLabel)
        authLabel.backgroundColor = .red
        authLabel.text = "Авторизируйтесь"
        authLabel.textColor = .white
        authLabel.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.top.equalTo(emailLabel.snp.bottom).offset(15)
            make.leading.equalTo(avatarUserImage.snp.trailing).offset(20)
        }
        
        
    }
    
    @objc func unlog() {
        keyChain.delete("name")
        keyChain.delete("secondName")
        keyChain.delete("email")
        keyChain.delete("token")
        nameLabel.text = "Имя и Фамилия"
        emailLabel.text = "E-Mail"
        register.isHidden = false
        buttonUnlog.isHidden = true
        cleanAvatar()
    }
    
    
    func cleanAvatar() {
        CoreDataManager().deleteAllData()
        avatarUserImage.image = UIImage(named: "woman")
        self.authLabel.isHidden = false
    }
    
    
    
    @objc func back() {
        navigationController?.pushViewController(MainStart.getController(controller: .mainViewController), animated: false)
    }
    }



extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage ??
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        )
        avatarUserImage.image = image
        guard let imageData = avatarUserImage.image!.pngData() else {return}
        CoreDataManager().saveData(photo: imageData)
        picker.dismiss(animated: true, completion: nil)
    }
}



