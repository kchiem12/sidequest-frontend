//
//  SignUpViewController.swift
//  SideQuest
//
//  Created by Ken Chiem on 11/23/22.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let whiteBackgroundView: UIView = UIView()
    let emailLabel: UILabel = UILabel()
    let passwordLabel: UILabel = UILabel()
    let firstNameLabel: UILabel = UILabel()
    let lastNameLabel: UILabel = UILabel()
    let phoneNumberLabel: UILabel = UILabel()
    let emailTextField: TextField = TextField()
    let passwordTextField: TextField = TextField()
    let firstNameTextField: TextField = TextField()
    let lastNameTextField: TextField = TextField()
    let phoneNumberTextField: TextField = TextField()
    let createButton: UIButton = UIButton()
    let profileImageView: UIImageView = UIImageView()
    let addProfileLabel: UILabel = UILabel()
    let imagePicker: UIImagePickerController = UIImagePickerController()
    let errorLabel: UILabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add gradient background
        gradient.frame = self.view.bounds
        gradient.colors = [
            UIColor(rgb: 0xD8DFF2).cgColor, UIColor(rgb: 0xE1F8F8).cgColor
        ]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
        // hides the back button on the navigationitem
        
        self.hideKeyboardWhenTappedAround()
        
        whiteBackgroundView.backgroundColor = .white
        whiteBackgroundView.layer.cornerRadius = 16
        whiteBackgroundView.layer.zPosition = 0 // set the uiview to back of z-index
        view.addSubview(whiteBackgroundView)
        
        profileImageView.image = UIImage(named: "profile_placeholder")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 65
        view.addSubview(profileImageView)
        
        addProfileLabel.text = "add profile picture"
        addProfileLabel.font = UIFont(name: "IBMPlexSans-Light", size: 12)
        addProfileLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeImage(gesture:))))
        addProfileLabel.textColor = UIColor(rgb: 0x7D91C5)
        addProfileLabel.isUserInteractionEnabled = true
        view.addSubview(addProfileLabel)
        
        emailLabel.text = "email"
        emailLabel.textColor = UIColor(rgb: 0x6EBABA)
        emailLabel.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        view.addSubview(emailLabel)
        
        emailTextField.backgroundColor = UIColor(rgb: 0xE1F8F8)
        emailTextField.layer.cornerRadius = 8
        emailTextField.textColor = .black
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        
        passwordLabel.text = "password"
        passwordLabel.textColor = UIColor(rgb: 0x6EBABA)
        passwordLabel.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        view.addSubview(passwordLabel)
        
        passwordTextField.backgroundColor = UIColor(rgb: 0xE1F8F8)
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.textColor = .black
        passwordTextField.textContentType = .init(rawValue: "")
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        firstNameLabel.text = "first name"
        firstNameLabel.textColor = UIColor(rgb: 0x6EBABA)
        firstNameLabel.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        view.addSubview(firstNameLabel)
        
        firstNameTextField.backgroundColor = UIColor(rgb: 0xE1F8F8)
        firstNameTextField.layer.cornerRadius = 8
        firstNameTextField.textColor = .black
        firstNameTextField.autocapitalizationType = .none
        firstNameTextField.autocorrectionType = .no
        view.addSubview(firstNameTextField)
        
        lastNameLabel.text = "last name"
        lastNameLabel.textColor = UIColor(rgb: 0x6EBABA)
        lastNameLabel.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        view.addSubview(lastNameLabel)
        
        lastNameTextField.backgroundColor = UIColor(rgb: 0xE1F8F8)
        lastNameTextField.layer.cornerRadius = 8
        lastNameTextField.textColor = .black
        lastNameTextField.autocorrectionType = .no
        lastNameTextField.autocapitalizationType = .none
        view.addSubview(lastNameTextField)
        
        phoneNumberLabel.text = "phone number"
        phoneNumberLabel.textColor = UIColor(rgb: 0x6EBABA)
        phoneNumberLabel.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        view.addSubview(phoneNumberLabel)
        
        phoneNumberTextField.backgroundColor = UIColor(rgb: 0xE1F8F8)
        phoneNumberTextField.layer.cornerRadius = 8
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.delegate = self
        phoneNumberTextField.autocapitalizationType = .none
        phoneNumberTextField.autocorrectionType = .no
        view.addSubview(phoneNumberTextField)
        
        createButton.setTitle("create account", for: .normal)
        createButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Light", size: 16)
        createButton.titleLabel?.textColor = UIColor(rgb: 0xE1F8F8)
        createButton.backgroundColor = UIColor(rgb: 0x6EBABA)
        createButton.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        createButton.layer.cornerRadius = 8
        view.addSubview(createButton)
        
        errorLabel.text = ""
        errorLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 20)
        errorLabel.textColor = UIColor(rgb: 0xdb4c42)
        errorLabel.sizeToFit()
        view.addSubview(errorLabel)
        
        setupConstraints()
        
    }
    
    // Converts the UIImage to Base64 String
    func convertImageToBase64String (img: UIImage) -> String {
        let extensionBase = img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        return "data:image/jpeg;base64,\(extensionBase)"
    }
    
    @objc func registerAccount() {
        
        NetworkManager.registerAccount(email: emailTextField.text!, password: passwordTextField.text!, first: firstNameTextField.text!, last: lastNameTextField.text!, phone_number: phoneNumberTextField.text!) { user, success, errorMsg in
            if success {
                
                let base64Rep = self.convertImageToBase64String(img: self.profileImageView.image!)
                NetworkManager.uploadAccImg(userID: user!.id, base64: base64Rep) { successs, error in
                    if !successs {
                        print("Error in uploading image")
                    }
                }
                UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first?.rootViewController = HomePage(user: user)
            } else {
                print("\(errorMsg!)")
                self.errorLabel.text = "One or more text fields are blank"
            }
        }
    }
    
    @objc func changeImage(gesture: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // When the user finish picking an image for their profile
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected dictionary of image, but got \(info)")
        }
        profileImageView.image = image
    }
    
    func setupConstraints() {
        whiteBackgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(533)
            make.width.equalTo(326)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(74)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(130)
            make.height.equalTo(130)
        }
        
        addProfileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(2)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(22)
            make.left.equalTo(emailTextField.snp.left)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(2)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(262)
            make.height.equalTo(46)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.equalTo(passwordTextField.snp.left)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(2)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(262)
            make.height.equalTo(46)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(passwordTextField.snp.left)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(2)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(262)
            make.height.equalTo(46)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(10)
            make.left.equalTo(passwordTextField.snp.left)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameLabel.snp.bottom).offset(2)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(262)
            make.height.equalTo(46)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(10)
            make.left.equalTo(passwordTextField.snp.left)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(2)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(262)
            make.height.equalTo(46)
        }

        createButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(18)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(46)
            make.width.equalTo(262)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(createButton.snp.bottom).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

}
