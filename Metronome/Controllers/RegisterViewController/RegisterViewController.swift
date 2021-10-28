//
//  ViewController.swift
//  Metronome
//
//  Created by User on 16.10.2021.
//

import UIKit
import Firebase
import KeychainSwift
import MessageUI

class RegisterViewController: UIViewController {
    
    
    var keyChain: KeychainSwift!
    var backButton: UIButton!
    var regButton: UIButton!
    var nameTF: UITextField!
    var secondTF: UITextField!
    var email: UITextField!
    var pass: UITextField!
    var nameTFlabel: UILabel!
    var secondTFLabel: UILabel!
    var emailTFLabel: UILabel!
    var passTFLabel: UILabel!
    var firstLine: UIView!
    var nameLabel: UILabel!
    var label: UILabel!
    var emailLabel: UILabel!
    
    var avatarUserImage: UIImageView! {
        didSet {
            avatarUserImage.image = UIImage(named: "woman")
            avatarUserImage.layer.cornerRadius = 60
            avatarUserImage.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyChain = KeychainSwift()
        view.backgroundColor = Constants.MainBackgroundColor
        regButton = UIButton()
        backButton = UIButton()
        label = UILabel()
        nameLabel = UILabel()
        emailLabel = UILabel()
        avatarUserImage = UIImageView()
        layout()
        regButton.addTarget(self, action: #selector(regPress), for: .touchUpInside)
        getData()
    }
    
    func getData() {
        if keyChain.getBool("Auth") ?? false {
            guard  let name = keyChain.get("name") else {return}
            guard let secondName = keyChain.get("secondName")  else {return}
            guard let email = keyChain.get("email")  else {return}
            
            nameLabel.text =  name + " " + secondName
            emailLabel.text = email
        }
        
    }
    
    @objc func regPress() {
        guard let name = nameTF.text, name != "",
              let secondName = secondTF.text, secondName != "",
              let email = email.text,
              let pass = pass.text else {return}
        print(email)
        Auth.auth().createUser(withEmail: email, password: pass) { (user, eror) in
            if eror != nil {
                let alert = UIAlertController(title: "Error",
                                              message: eror?.localizedDescription,
                                              preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            guard eror == nil else {return}
            guard user != nil else {return}
            self.keyChain.set(true, forKey: "Auth")
            self.keyChain.set((user?.user.refreshToken!)!, forKey: "token")
            self.keyChain.set(name, forKey: "name")
            self.keyChain.set(secondName, forKey: "secondName")
            self.keyChain.set(email, forKey: "email")
            self.sendEmails(email: email)
            NetworkManager().registerOfStartIfAuth()
            MainStart.present(view: self, controller: .settingController)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        MainStart.present(view: self, controller: .registerViewController)
    }
    
    
    func layout() {
        nameTF = UITextField()
        secondTF = UITextField()
        email = UITextField()
        pass = UITextField()
        nameTFlabel = UILabel()
        secondTFLabel = UILabel()
        emailTFLabel = UILabel()
        passTFLabel = UILabel()
        
        view.addSubview(regButton)
        regButton.setImage(UIImage(named: "regButton"), for: .normal)
        regButton.snp.makeConstraints { make in
            make.width.equalTo( 19.5)
            make.height.equalTo( 36.4)
            make.top.equalTo(view.snp.top).offset(130)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.setImage(imager.path(.back)(), for: .normal)
        
        
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
            make.width.equalTo(120)
            make.height.equalTo(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(avatarUserImage.snp.trailing).offset(20)
        }
        view.addSubview(nameTFlabel)
        nameTFlabel.text = "Имя"
        nameTFlabel.textColor = .white
        nameTFlabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(170)
            make.top.equalTo(avatarUserImage.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        view.addSubview(nameTF)
        nameTF.backgroundColor = Constants.allertColor
        nameTF.borderWidth = 1
        nameTF.borderColor = .white
        nameTF.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(nameTFlabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
        
        view.addSubview(secondTFLabel)
        secondTFLabel.text = "Фамилия"
        secondTFLabel.textColor = .white
        secondTFLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(170)
            make.top.equalTo(nameTF.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        view.addSubview(secondTF)
        secondTF.backgroundColor = Constants.allertColor
        secondTF.borderWidth = 1
        secondTF.borderColor = .white
        secondTF.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(secondTFLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
        view.addSubview(emailTFLabel)
        emailTFLabel.text = "Почта/Логин"
        emailTFLabel.textColor = .white
        emailTFLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(170)
            make.top.equalTo(secondTF.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        view.addSubview(email)
        email.backgroundColor = Constants.allertColor
        email.borderWidth = 1
        email.borderColor = .white
        email.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(emailTFLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
        view.addSubview(passTFLabel)
        passTFLabel.text = "Пароль"
        passTFLabel.textColor = .white
        passTFLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(170)
            make.top.equalTo(email.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        view.addSubview(pass)
        pass.backgroundColor = Constants.allertColor
        pass.borderWidth = 1
        pass.borderColor = .white
        pass.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(passTFLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
    }
    
    
    @objc func back() {
        navigationController?.pushViewController(MainStart.getController(controller: .settingController), animated: false)
    }
}
extension RegisterViewController: MFMailComposeViewControllerDelegate{
    func sendEmails(email: String) {
        //TODO:  You should chack if we can send email or not
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject("metronome developers team)")
            mail.setMessageBody("<p>Добро пожаловать в команду пользователей приложения метроном))) </p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Application is not able to send an email")
        }
    }
    
    //MARK: MFMail Compose ViewController Delegate method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
