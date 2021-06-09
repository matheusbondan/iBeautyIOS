//
//  ScheduleAPI.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 31/05/21.
//

import Foundation

class ScheduleAPI {
    
    static func doAppointment(salonID: String, completeDate: String, hour:String, dayMonth:String, serviceID: String, employeeID: String, userID: String, dayMonthYear: String, completion: @escaping (AppointmentModel?, APIError?) -> Void){
        
        let endpoint = "http://localhost:3000/appointments"
        
        let parameters = [
            "salonID":salonID,
            "serviceID": serviceID,
            "employeeID":employeeID,
            "completeDate": completeDate,
            "userID":userID,
            "hour":hour,
            "dayMonth":dayMonth,
            "dayMonthYear":dayMonthYear
        ]
        
        NetworkRequests().request(url: endpoint, method: .post, parameters: parameters, headers: APIConfig.header, success: { (data) in
            
            do {
                let balance = try JSONDecoder().decode(AppointmentModel.self, from: data)
                
                completion(balance, nil)
            } catch {
                completion(nil, APIError(type:.defaultError))
            }
            
        }) { (error) in
            completion(nil, error)
        }
    }
   
    
}
