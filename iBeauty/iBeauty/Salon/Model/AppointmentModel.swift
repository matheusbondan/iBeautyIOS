//
//  AppointmentModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 31/05/21.
//

import Foundation

open class AppointmentModel:NSObject, Codable {
    
    open var appointmentID:String?
    open var completeDate:String?
    open var service: ServiceModel?
    open var employee: EmployeeModel?
    open var salon: SalonModel?
    open var hour:String?
    open var dayMonth:String?
    open var dayMonthYear:String?
    open var user: UserModel?
    
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .appointmentID)) as String??) { appointmentID = value }
        if let value = ((try? values.decode(String?.self, forKey: .completeDate)) as String??) { completeDate = value }
        if let value = ((try? values.decode(ServiceModel?.self, forKey: .service)) as ServiceModel??) { service = value }
        if let value = ((try? values.decode(EmployeeModel?.self, forKey: .employee)) as EmployeeModel??) { employee = value }
        if let value = ((try? values.decode(SalonModel?.self, forKey: .salon)) as SalonModel??) { salon = value }
        if let value = ((try? values.decode(String?.self, forKey: .hour)) as String??) { hour = value }
        if let value = ((try? values.decode(String?.self, forKey: .dayMonth)) as String??) { dayMonth = value }
        if let value = ((try? values.decode(String?.self, forKey: .dayMonthYear)) as String??) { dayMonthYear = value }
        
        if let value = ((try? values.decode(UserModel?.self, forKey: .user)) as UserModel??) { user = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( appointmentID, forKey: .appointmentID)
        try container.encode( completeDate, forKey: .completeDate)
        try container.encode( service, forKey: .service)
        try container.encode( employee, forKey: .employee)
        try container.encode( salon, forKey: .salon)
        try container.encode( hour, forKey: .hour)
        try container.encode( dayMonth, forKey: .dayMonth)
        try container.encode( dayMonthYear, forKey: .dayMonthYear)
        try container.encode( user, forKey: .user)
    }

    enum Keys: String, CodingKey {
        case appointmentID      = "_id"
        case completeDate        = "completeDate"
        case service           = "service"
        case employee      = "employee"
        case salon        = "salon"
        
        case hour        = "hour"
        case dayMonth        = "dayMonth"
        case dayMonthYear        = "dayMonthYear"
        case user        = "user"
        
    }
}
