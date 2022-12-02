//
//  NetworkManager.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import UIKit
import Alamofire

class NetworkManager {
    
    //TODO: error handling in signup

    static let host = "http://34.85.181.121"
    
    
    // function to register an account
    static func registerAccount(email: String, password: String, first: String, last: String, phone_number: String, completion: @escaping (User?, Bool, _ errorMsg: String?) -> Void) {
        let endpoint = "\(host)/api/register/"
        
        // Handles bad input
        if (email == "" || password == "" || first == "" || last == "" || phone_number == "") {
            completion(nil, false, "One or more text fields are blank")
        }
        
        let params: Parameters = [
            "email": email,
            "password": password,
            "first": first,
            "last": last,
            "phone_number": phone_number
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(User.self, from: data) {
                    completion(userResponse, true, nil)
                } else {
                    print("Failed to decode registerAccount")
                }
            case .failure(let error):
                print(error.localizedDescription)
                // TODO: add a delegate so that we can present an error message
            }
        }
    }
    
    // function to login
    static func loginAccount(email: String, password: String, completion: @escaping (User?, Bool, _ errorMsg: String?) -> Void) {
        let endpoint = "\(host)/api/login/"
        
        // Handles bad input
        if (email == "" || password == "") {
            completion(nil, false, "One or more text fields are blank")
        }
        
        let params: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(User.self, from: data) {
                    completion(userResponse, true, nil)
                } else {
                    print("Failed to login")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, false, error.localizedDescription)
            }
        }
    }
    
    // function to upload an image
    static func uploadAccImg(userID: Int, base64: String,  completion: @escaping (_ success: Bool, String?) -> Void) {
        let endpoint = "\(host)/api/user/\(userID)/upload/"
        
        let params: Parameters = [
            "image_data": base64
        ]
        
        print("\(base64)")
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
        
    }
    
    // function to get all posts
    static func getAllPosts(completion: @escaping ([Job]) -> Void) {
        let endpoint = "\(host)/api/job/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode([Job].self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getAllPosts")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // function to create a post
    static func createPost(userID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int, completion: @escaping (Job) -> Void) {
        let endpoint = "\(host)/api/user/\(userID)/"
        let params: Parameters = [
            "title": title,
            "description": description,
            "location": location,
            "date_activity": date_activity,
            "duration": duration,
            "reward": reward,
            "category": category,
            "longtitude": longtitude,
            "latitude": latitude
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Job.self, from: data) {
                    completion(userResponse)
                }
                else {
                    print("Failed to decode createPost")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        } 
    }

    

}
