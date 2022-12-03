//
//  TestViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/30/22.
//

import UIKit
import SnapKit
import Foundation

class TestViewController: UIViewController {

    let testImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let url = URL(string: "https://None.s3.us-east-1.amazonaws.com/SUI3WA7SGNS4W1DI.jpg")
        testImageView.setImageFromStringrlL(url: "https://images-hack-challenge-jack.s3.us-east-2.amazonaws.com/IG4BETO2DTPBDPKH.jpg")
        testImageView.contentMode = .scaleAspectFill
        testImageView.clipsToBounds = true
        view.addSubview(testImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        testImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }

}

extension UIImageView {
    func setImageFromStringrlL(url: String) {
      if let url = URL(string: url) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
