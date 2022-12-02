//
//  AddJobViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit
import SnapKit

class AddJobViewController: UIViewController {
    
    // Set Up Variables
    var createPostButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)
        
        // Set Up Properties
        createPostButton.setTitle("Create post!", for: .normal)
        createPostButton.layer.cornerRadius = 16
        createPostButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
        createPostButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        view.addSubview(createPostButton)
        
        // Set Up Constraints
        createPostButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)

        }
    }
    
    @objc func createPost() {
        present(PublishJobPresentViewController(), animated: true)
    }

}


