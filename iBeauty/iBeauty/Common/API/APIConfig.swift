//
//  APIConfig.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 09/06/21.
//

import Foundation
import Alamofire

class APIConfig {
    
    public static var baseURL:String {
        //DEV
//        return "http://localhost:4000/"
        
        //PROD
        return "https://ibeautynodejs.herokuapp.com/"
       
    }
    
    public static var header: HTTPHeaders! {
        var headers = HTTPHeaders()
        
        headers.add(name: "Content-Type", value: "application/json")
        
        if AppContextHelper.share.isLogged ?? false {
            headers.add(name: "x-access-token", value: AppContextHelper.share.jwt ?? "")
        }
        
        
        return headers
    }
}
