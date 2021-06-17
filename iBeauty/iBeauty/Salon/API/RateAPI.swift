//
//  RateAPI.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 03/06/21.
//

import Foundation

class RateAPI {
    
    static func addRate(salonID: String, userID: String, rateScore: Int, comment: String, completion: @escaping (RateModel?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "ratings"
        
        let parameters = [
            "salonID":salonID,
            "userID":userID,
            "rateScore":rateScore,
            "comment":comment
        ] as [String : Any]
        
        NetworkRequests().request(url: endpoint, method: .post, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode(RateModel.self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }

    static func getRatingsBySalon(salonID:String, completion: @escaping ([RateModel]?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "ratings/salon/\(salonID)"
        
        NetworkRequests().request(url: endpoint, method: .get, parameters: nil, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode([RateModel].self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
    
}
