//
//  UserAPI.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 04/06/21.
//

import Foundation

class UserAPI {
    
    static func changePassword(userID: String, currentPassword: String, newPassword: String, completion: @escaping (UserModel?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "users/\(userID)/changepassword"
        
        let parameters = [
            "currentPassword":currentPassword,
            "newPassword":newPassword
        ] as [String : Any]
        
        NetworkRequests().request(url: endpoint, method: .patch, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
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
    
    static func changeUserData(userID: String, email: String, name: String, phone: String, completion: @escaping (UserModel?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "users/\(userID)/changedata"
        
        let parameters = [
            "email":email,
            "name":name,
            "phone":phone
        ] as [String : Any]
        
        NetworkRequests().request(url: endpoint, method: .patch, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
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
    
    static func getAppointments(userID:String, completion: @escaping ([AppointmentModel]?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "appointments/\(userID)"
        
        NetworkRequests().request(url: endpoint, method: .get, parameters: nil, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode([AppointmentModel].self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
    
}

