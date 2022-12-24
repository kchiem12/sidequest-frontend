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
    var gigAmount: String
    var profilePic: String
    var profileName: String
    var gigDescription: String
    var categoryName: String
    var relevantSkills: String
    var otherNotes: String
    var favorite: Bool
    var job: Job?
    
    init(gigName: String, gigAmount: String, profilePic: String, profileName: String, gigDescription: String, categoryName: String, relevantSkills: String, otherNotes: String, favorite: Bool, job: Job?) {
        self.gigName = gigName
        self.gigAmount = gigAmount
        self.profilePic = profilePic
        self.profileName = profileName
        self.gigDescription = gigDescription
        self.categoryName = categoryName
        self.relevantSkills = relevantSkills
        self.otherNotes = otherNotes
        self.favorite = favorite
        self.job = job
    }
}
