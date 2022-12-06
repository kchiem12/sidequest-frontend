//
//  Job.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/27/22.
//

import Foundation

// Job Model
struct Job: Codable {
    let id: Int
    var title: String
    var description: String
    var location: String
    var date_created: String
    var date_activity: String
    var duration: Int
    var reward: String?
    var category: String
    var done: Bool
    var taken: Bool
    var longtitude: Int
    var latitude: Int
    var asset: [SimpleImage]
    var poster: [SimpleUser]
    var receiver: [SimpleUser]
    var potential: [SimpleUser]
}

struct JobList: Codable {
    var jobs: [Job]
}
