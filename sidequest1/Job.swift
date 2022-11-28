//
//  Job.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/21/22.
//

import Foundation
import UIKit

class Job{
    var jobCategoryName: String
    var isSelected: Bool
    
    init (jobCategoryName: String, isSelected: Bool) {
        self.jobCategoryName = jobCategoryName
        self.isSelected = isSelected
    }
}
