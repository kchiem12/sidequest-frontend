//
//  UIViewController+AddGestureViewController.swift
//  SideQuest
//
//  Created by Ken Chiem on 11/21/22.
//

import UIKit

// To dismiss keybord when tapping anywhere on screen
// Source: https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
