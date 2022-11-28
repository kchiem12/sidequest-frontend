//
//  NetworkManager.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import UIKit
import Alamofire

class NetworkManager {

    static let host = "http://34.85.181.121"
    
    
    // function to register an account
    static func registerAccount(email: String, password: String, first: String, last: String, phone_number: String, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/api/register/"
        
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
                    completion(userResponse)
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
    static func loginAccount(email: String, password: String, completion: @escaping (User) -> Void) {
        let
    }
    
    

}
