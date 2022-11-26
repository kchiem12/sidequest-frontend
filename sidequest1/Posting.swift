//
//  Posting.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/24/22.
//

import Foundation
import UIKit

class Posting{
    var gigName: String
    var gigAmount: Double
    var profilePic: String
    var profileName: String
    var gigDescription: String
    
    init(gigName: String, gigAmount: Double, profilePic: String, profileName: String, gigDescription: String) {
        self.gigName = gigName
        self.gigAmount = gigAmount
        self.profilePic = profilePic
        self.profileName = profileName
        self.gigDescription = gigDescription
    }
}
