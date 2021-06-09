//
//  NetworkRequests.swift
//  TransactionPod
//
//  Created by Thiago Bertoletti on 20/04/20.
//

import Foundation
import Alamofire

class NetworkRequests{
    
    public static let share = NetworkRequests()
    
    func request(url: String, method: HTTPMethod, parameters: Parameters?, headers:HTTPHeaders, success: @escaping (Data) -> Void, failure: @escaping (APIError) -> Void) {
        
        print("REQUEST TO: ", url)
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<399).responseJSON { (response) in
            switch response.result{
                case .success:
                    if let data = response.data {
                      success(data)
                    }
                    else{
                        success(Data())
                    }
                case .failure(let afError):
                    
                    if response.response?.statusCode == 401{
                        DispatchQueue.main.async {
//                            TSXTransmitSDKXm.sharedInstance().logoutAsynchronously { [weak self] (success, error) in
//                                TransactionFactory.getBeatSessionPopup(alertTitle: "beat_session.alert.text".localized, buttonTitle: "beat_session.alert_button.label".localized)
//                            }
                        }
                        
                        
                        return
                    }
                    
                    if let data = response.data {
                        do {
                            let errorEntity = try JSONDecoder().decode(APIError.self, from: data)
                            failure(errorEntity)
                        } catch {
                            failure(APIError(type: .defaultError))
                        }
                    }
                    else if let error = afError.underlyingError as NSError? {
                        switch error.code {
                        case NSURLErrorNetworkConnectionLost, -1009:
                            failure(APIError(type: .reachabilityError))
                        default:
                            failure(APIError(type: .defaultError))
                        }
                    }
                    else{
                        failure(APIError(type: .defaultError))
                    }
            }
        }
    }
}
