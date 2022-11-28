//
//  Job.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/21/22.
//

import Foundation
import UIKit

struct Joba: Codable{
    var jobCategoryName : String
    
    init (jobCategoryName : String) {
        self.jobCategoryName = jobCategoryName
    }
}
