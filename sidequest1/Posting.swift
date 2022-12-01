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
    var categoryName: String
    var relevantSkills: String
    var otherNotes: String
    var favorite: Bool
    
    init(gigName: String, gigAmount: Double, profilePic: String, profileName: String, gigDescription: String, categoryName: String, relevantSkills: String, otherNotes: String, favorite: Bool) {
        self.gigName = gigName
        self.gigAmount = gigAmount
        self.profilePic = profilePic
        self.profileName = profileName
        self.gigDescription = gigDescription
        self.categoryName = categoryName
        self.relevantSkills = relevantSkills
        self.otherNotes = otherNotes
        self.favorite = favorite
    }
}
