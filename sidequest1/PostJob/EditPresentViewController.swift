//
//  EditPresentViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 12/2/22.
//

import UIKit

class EditPresentViewController: UIViewController {
    
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
    
    let job: Job
    
    init(job: Job) {
        self.job = job
        super.init(nibName: nil, bundle: nil)
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
    var notesField = UITextView()
    
    var publishButton = UIButton()
    
    let categories = ["Research Study", "Entertainment", "Labor", "Tutoring", "Pet Sitting"]


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        createView()
        
        // Set Up Properties
        gigLabel.text = "Gig title"
        gigLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        gigLabel.font = .systemFont(ofSize: 16)
        view.addSubview(gigLabel)
        
        gigTitleField.text = job.title
        gigTitleField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        gigTitleField.layer.cornerRadius = 8
        view.addSubview(gigTitleField)
        
        payLabel.text = "Pay"
        payLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        payLabel.font = .systemFont(ofSize: 16)
        view.addSubview(payLabel)
        
        payField.text = job.reward
        payField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        payField.layer.cornerRadius = 8
        view.addSubview(payField)
        
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        descriptionLabel.font = .systemFont(ofSize: 16)
        view.addSubview(descriptionLabel)
        
        descriptionField.text = job.description
        descriptionField.font = .systemFont(ofSize: 16)
        descriptionField.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 20)
        descriptionField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        descriptionField.layer.cornerRadius = 8
        descriptionField.isEditable = true
        view.addSubview(descriptionField)
        
        categoryLabel.text = "Category"
        categoryLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        categoryLabel.font = .systemFont(ofSize: 16)
        view.addSubview(categoryLabel)
        
        categoryField.text = job.category
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
        
        notesField.font = .systemFont(ofSize: 16)
        notesField.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 20)
        notesField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        notesField.layer.cornerRadius = 8
        view.addSubview(notesField)
        
        publishButton.setTitle("Publish", for: .normal)
        publishButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        publishButton.layer.cornerRadius = 16
        publishButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
//        publishButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(publishButton)
        
        // Set Up Constraints
        
        gigLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(130)
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
        
        func createView() {
            let newView = UIView(frame: CGRect(x: 0, y: 110, width: view.frame.width, height: 670))
            newView.layer.cornerRadius = 16
            newView.backgroundColor = .white
            view.addSubview(newView)
        }
        
    }
}

extension EditPresentViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension EditPresentViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryField.text = categories[row]
        categoryField.resignFirstResponder()
    }
}
