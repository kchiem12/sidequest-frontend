//
//  PublishJobPresentViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/28/22.
//

import UIKit

class PublishJobPresentViewController: UIViewController {
    
    class TextFieldWithPadding: UITextField {
        var textPadding = UIEdgeInsets(
            top: 10,
            left: 20,
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
    var publishButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        createView()
        
        // Set Up Properties
        gigLabel.text = "Gig title"
        gigLabel.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        gigLabel.font = .systemFont(ofSize: 16)
        view.addSubview(gigLabel)
        
        gigTitleField.layer.backgroundColor = UIColor(red: 0.882, green: 0.973, blue: 0.973, alpha: 1).cgColor
        gigTitleField.layer.cornerRadius = 8
        view.addSubview(gigTitleField)
        
        publishButton.setTitle("Publish", for: .normal)
        publishButton.layer.cornerRadius = 16
        publishButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
        view.addSubview(publishButton)
        
        // Set Up Constraints
        publishButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
    }
    
        func createView() {
            let newView = UIView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 630))
            newView.layer.cornerRadius = 16
            newView.backgroundColor = .white
            view.addSubview(newView)
            
        }
    }
    
}
