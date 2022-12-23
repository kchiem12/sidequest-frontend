//
//  PublishJobPresentViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/28/22.
//

import UIKit

class PublishJobPresentViewController: UIViewController, UITextFieldDelegate {
    
    class TextFieldWithPadding: UITextField {
        var textPadding = UIEdgeInsets(
            top: 10,
            left: 15,
            bottom: 10,
            right: 20
        )

        override func textRect(forBounds bounds: CGRect) -> CGRect {
                let rect = super.textRect(forBounds: bounds)
                return rect.inset(by: textPadding)
            }

            override func editingRect(forBounds bounds: CGRect) -> CGRect {
                let rect = super.editingRect(forBounds: bounds)
                return rect.inset(by: textPadding)
            }
    }
    
    // Set Up Variables
    var gigLabel = UILabel()
    var gigTitleField = TextFieldWithPadding()
    var payLabel = UILabel()
    var payField = TextFieldWithPadding()
    var descriptionLabel = UILabel()
    var descriptionField = UITextView()
    var categoryLabel = UILabel()
    var categoryField = TextFieldWithPadding()
    var categoryPicker = UIPickerView()
    var skillsLabel = UILabel()
    var skillsField = TextFieldWithPadding()
    var notesLabel = UILabel()
    var notesField = TextFieldWithPadding()
    var user: User

    var publishButton = UIButton()
    
    let categories = ["Research Study", "Entertainment", "Labor", "Tutoring", "Pet Sitting"]
    
    weak var delegate: CreatePostDelegate?
    
    init(delegate: CreatePostDelegate, user: User) {
        self.delegate = delegate
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Set Up Properties
        gigLabel.text = "Gig title"
        gigLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        gigLabel.font = .systemFont(ofSize: 16)
        view.addSubview(gigLabel)
        
        gigTitleField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        gigTitleField.layer.cornerRadius = 8
        view.addSubview(gigTitleField)
        
        payLabel.text = "Pay"
        payLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        payLabel.font = .systemFont(ofSize: 16)
        view.addSubview(payLabel)
        
        payField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        payField.addTarget(self, action: #selector(rewardTextFieldChanged), for: .editingChanged)
        payField.placeholder = "$20.00"
        payField.layer.cornerRadius = 8
        view.addSubview(payField)
        
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        descriptionLabel.font = .systemFont(ofSize: 16)
        view.addSubview(descriptionLabel)
        
        descriptionField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
        descriptionField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        descriptionField.layer.cornerRadius = 8
        descriptionField.isEditable = true
        view.addSubview(descriptionField)
        
        categoryLabel.text = "Category"
        categoryLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        categoryLabel.font = .systemFont(ofSize: 16)
        view.addSubview(categoryLabel)
        
        categoryField.attributedPlaceholder = NSAttributedString(string: "Select category...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.435, green: 0.729, blue: 0.733, alpha: 1)])
        categoryField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        categoryField.layer.cornerRadius = 8
        view.addSubview(categoryField)
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryField.inputView = categoryPicker
        
        skillsLabel.text = "Relevant Skills"
        skillsLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        skillsLabel.font = .systemFont(ofSize: 16)
        view.addSubview(skillsLabel)
        
        skillsField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        skillsField.layer.cornerRadius = 8
        view.addSubview(skillsField)
        
        notesLabel.text = "Other Notes"
        notesLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        notesLabel.font = .systemFont(ofSize: 16)
        view.addSubview(notesLabel)
        
        notesField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        notesField.layer.cornerRadius = 8
        view.addSubview(notesField)
        
        publishButton.setTitle("Publish", for: .normal)
        publishButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        publishButton.layer.cornerRadius = 16
        publishButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
        publishButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(publishButton)
        
        // Set Up Constraints
        
        gigLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(40)
            make.left.equalTo(self.view.snp.left).offset(30)
        }
        
        gigTitleField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(47)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(gigLabel.snp.bottom).offset(1)
        }
        
        payLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(gigLabel.snp.left)
            make.top.equalTo(gigTitleField.snp.bottom).offset(10)
        }
        
        payField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(47)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(payLabel.snp.bottom).offset(1)
        }
        
        descriptionLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(gigLabel.snp.left)
            make.top.equalTo(payField.snp.bottom).offset(10)
        }
        
        descriptionField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(73)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(1)
        }
        
        categoryLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(gigLabel.snp.left)
            make.top.equalTo(descriptionField.snp.bottom).offset(10)
        }
        
        categoryField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(47)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(categoryLabel.snp.bottom).offset(1)
        }
        
        skillsLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(gigLabel.snp.left)
            make.top.equalTo(categoryField.snp.bottom).offset(10)
        }
        
        skillsField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(47)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(skillsLabel.snp.bottom).offset(1)
        }
        
        notesLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(gigLabel.snp.left)
            make.top.equalTo(skillsField.snp.bottom).offset(10)
        }
        
        notesField.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(333)
            make.height.equalTo(73)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(notesLabel.snp.bottom).offset(1)
        }
        
        publishButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    
//        func createView() {
//            let newView = UIView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 630))
//            newView.layer.cornerRadius = 16
//            newView.backgroundColor = .white
//            view.addSubview(newView)
//
//        }
        
    }
    
    // To format the rewards textfield so that it only accepts decimal numbers
    @objc func rewardTextFieldChanged(_ textfield: UITextField) {
        if let string = textfield.text?.currencyInputFormatting() {
            textfield.text = string
        }
    }
    
    @objc func saveAction() {

        //TODO: Handle any error/null cases. Ex. if the reward textfield is empty, then we should not create a post
        let userID = user.id
        let title = gigTitleField.text!
        let description = descriptionField.text!
        let location = ""
        let date_activity = ""
        let duration = 0
        let reward = String(payField.text!.dropFirst())
        let category = categoryField.text!
        let longtitude = 0
        let latitude = 0
        
        delegate?.createPost(userID: userID, title: title, description: description, location: location, date_activity: date_activity, duration: duration, reward: reward, category: category, longtitude: longtitude, latitude: latitude)
        
        dismiss(animated: true)
    }
    
    // Makes it so the phone number textfield only accepts numerical input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: ".0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
        
        if countdots > 0 && string == "." {
            return false
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}


extension PublishJobPresentViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension PublishJobPresentViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryField.text = categories[row]
        categoryField.resignFirstResponder()
    }
}

//https://stackoverflow.com/questions/29782982/how-to-input-currency-format-on-a-text-field-from-right-to-left-using-swift
extension String {

    // formatting text for currency textField
    func currencyInputFormatting() -> String {
    
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
    
        var amountWithPrefix = self
    
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
    
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
    
        return formatter.string(from: number)!
    }
}

protocol CreatePostDelegate: UIViewController {
        func createPost(userID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int)
    }
