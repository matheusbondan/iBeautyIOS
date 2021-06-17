//
//  SalonAPI.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/04/21.
//

import Foundation

class SalonAPI {
    
    func getCategories(completion: @escaping ([CategoryModel]?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "categories"
        
        
        
        NetworkRequests().request(url: endpoint, method: .get, parameters: nil, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode([CategoryModel].self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
    
    
    func getSalonByService(idService:String, lat:Double?, lng:Double?, dayMonthYear:String, hour:String, haveLocation:Bool, completion: @escaping ([SalonModel]?, APIError?) -> Void){
        
        let endpoint = APIConfig.baseURL + "salons/salonlist"
        
        let parameters = [
            "serviceID":idService,
            "lat":lat ?? 0.0,
            "lng":lng ?? 0.0,
            "dayMonthYear":dayMonthYear,
            "hour":hour,
            "haveLocation":haveLocation
        ] as [String : Any]
        
        
        
        NetworkRequests().request(url: endpoint, method: .post, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode([SalonModel].self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
}
