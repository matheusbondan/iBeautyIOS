//
//  LoginAPI.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 17/04/21.
//

import Foundation

import Foundation
import Alamofire

class LoginAPI {
    
    func login(email: String, password: String, completion: @escaping (UserModel?, APIError?) -> Void){
        
        let endpoint = "http://localhost:3000/login"
        
        let parameters = [
            "email":email,
            "password": password
        ]
        
        
        NetworkRequests().request(url: endpoint, method: .post, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode(UserModel.self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
    
    func register(name: String, email: String, phone: String, cpf: String, password: String, completion: @escaping (UserModel?, APIError?) -> Void){
        
        let endpoint = "http://localhost:3000/users"
        
        let parameters = [
            "username":name,
            "email": email,
            "phone":phone,
            "cpf": cpf,
            "password": password
        ]
        
        
        NetworkRequests().request(url: endpoint, method: .post, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode(UserModel.self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
    
}

class APIConfig {
    public static var header: HTTPHeaders! {
        var headers = HTTPHeaders()
        
        headers.add(name: "Content-Type", value: "application/json")
        
        return headers
    }
}
