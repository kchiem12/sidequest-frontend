//
//  moreInfoPresentViewController.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/25/22.
//

import UIKit

class moreInfoPresentViewController: UIViewController {
    
    
    let posting: Posting
   
    init(posting: Posting) {
        self.posting = posting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }

}

protocol ProtocolDelegate: UICollectionViewCell {
    
}

