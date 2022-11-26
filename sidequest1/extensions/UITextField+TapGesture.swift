//
//  UITextField+TapGesture.swift
//  SideQuest
//
//  Created by Ken Chiem on 11/21/22.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
