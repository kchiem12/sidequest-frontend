//
//  SimpleJob.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/27/22.
//

import Foundation

struct SimpleJob: Codable {
    let id: Int?
    var title: String?
    var reward: String?
    var done: Bool?
}
