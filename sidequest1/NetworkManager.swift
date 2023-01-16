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
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate(statusCode: 200..<401).responseData { response in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode {
                case 201:
                    let jsonDecoder = JSONDecoder()
                    if let userResponse = try? jsonDecoder.decode(User.self, from: data) {
                        print(userResponse.token)
                        completion(userResponse, true, nil)
                    } else {
                        print("Failed to decode registerAccount")
                    }
                case 400:
                    if let errorMessage = try? JSONDecoder().decode(Error.self, from: data) {
                        completion(nil, false, errorMessage.error)
                    } else {
                        print("Failed to decode error message")
                    }
                default:
                    print("Unknown status code")
                }
            case .failure(let error):
                print(error.localizedDescription)
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
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate(statusCode: 200..<405).responseData { response in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode {
                case 200:
                    let jsonDecoder = JSONDecoder()
                    if let userResponse = try? jsonDecoder.decode(User.self, from: data) {
                        completion(userResponse, true, nil)
                    } else {
                        print("Failed to login")
                    }
                case 401:
                    if let errorMessage = try? JSONDecoder().decode(Error.self, from: data) {
                        completion(nil, false, errorMessage.error)
                    } else {
                        print("Failed to decode error message")
                    }
                default:
                    print("Unknown status code")
                }
            case .failure(let error):
                print(error);
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
    static func getAllPosts(completion: @escaping (JobList) -> Void) {
        let endpoint = "\(host)/api/job/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(JobList.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getAllPosts")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getSpecificUser(userID: Int, completion: @escaping (User) -> Void) {
        
        let endpoint = "\(host)/api/user/\(userID)/"
        
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(User.self, from: data) {
                    completion(userResponse)
                } else {
                    print("failed to decode user specific")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // function to create a post
    static func createPost(userID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int, other_notes: String, relevant_skills: String, completion: @escaping (Job) -> Void) {
        let endpoint = "\(host)/api/user/\(userID)/job/"
        let params: Parameters = [
            "title": title,
            "description": description,
            "location": location,
            "date_activity": date_activity,
            "duration": duration,
            "reward": reward,
            "category": category,
            "longtitude": longtitude,
            "latitude": latitude,
            "other_notes": other_notes,
            "relevant_skills": relevant_skills
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
    
    static func uploadJobAsset(jobID: Int, base64: String, completion: @escaping (_ success: Bool, String?) -> Void) {
        
        let endpoint = "\(host)/api/job/\(jobID)/upload/"
        
        let params: Parameters = [
            "image_data": base64
        ]
        
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    // Function to allow users to express interest for a job
    static func interestInJob(userID: Int, jobID: Int, completion: @escaping (_ success: Bool, String?) -> Void) {
        let endpoint = "\(host)/api/user/\(userID)/job/\(jobID)/"
        
        let params: Parameters = [:]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate(statusCode: 200..<405).responseData { response in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode {
                case 201:
                    completion(true, nil)
                case 404:
                    if let error = try? JSONDecoder().decode(Error.self, from: data) {
                        completion(false, error.error)
                    } else {
                        completion(false, "Failed to decode error")
                    }
                default:
                    print("Invalid status code thrown")
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    static func getSpecificJob(jobID: Int, completion: @escaping (Job?) -> Void) {
        let endpoint = "\(host)/api/job/\(jobID)/"
        
        
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Job.self, from: data) {
                    completion(userResponse)
                } else {
                    print("failed to decode")
                }
            case .failure(_):
                completion(nil)
                print("failed")
            }
        }
    }
    
    // to update a posting
    static func updateJob(jobId: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int, other_notes: String, relevant_skills: String, completion: @escaping (Bool) -> Void) {
        
        let endpoint = "\(host)/api/job/\(jobId)/"
        
        print(endpoint)
        
        let params: Parameters = [
            "title": title,
            "description": description,
            "location": location,
            "date_activity": date_activity,
            "duration": duration,
            "reward": reward,
            "category": category,
            "longtitude": longtitude,
            "latitude": latitude,
            "other_notes": other_notes,
            "relevant_skills": relevant_skills
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    // Archives a job (currently it deletes, but we may want it to do something else instead)
    static func archiveJob(jobID: Int, completion: @escaping (Bool) -> Void) {
        
        let endpoint = "\(host)/api/job/\(jobID)/"
        
        AF.request(endpoint, method: .delete).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    // Function to log user out
    static func logOut(token: String, completion: @escaping (Bool, String?) -> Void) {
        let endpoint = "\(host)/api/logout/"
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        AF.request(endpoint, method: .post, headers: header).validate(statusCode: 200..<405).responseData { response in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode {
                case 200:
                    if let message = try? JSONDecoder().decode(MessageJSON.self, from: data) {
                        completion(true, message.message)
                    } else {
                        print("Failed to decode message")
                    }
                case 400:
                    if let errorMessage = try? JSONDecoder().decode(Error.self, from: data) {
                        completion(false, errorMessage.error)
                    } else {
                        print("Failed to decode error")
                    }
                default:
                    print("Unknown status code")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    

}
