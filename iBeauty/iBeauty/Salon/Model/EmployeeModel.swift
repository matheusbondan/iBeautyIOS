//
//  EmployeeModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation
import UIKit

open class EmployeeModel:NSObject, Codable {
    
    open var name:String?
    open var employeeId: String?
    open var services: [ServiceModel]?
    open var salonID: String?
    open var categoryID: String?
    open var creationDate: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .employeeId)) as String??) { employeeId = value }
        if let value = ((try? values.decode(String?.self, forKey: .name)) as String??) { name = value }
        if let value = ((try? values.decode([ServiceModel]?.self, forKey: .services)) as [ServiceModel]??) { services = value }
        if let value = ((try? values.decode(String?.self, forKey: .salonID)) as String??) { salonID = value }
        if let value = ((try? values.decode(String?.self, forKey: .creationDate)) as String??) { creationDate = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( employeeId, forKey: .employeeId)
        try container.encode( name, forKey: .name)
        try container.encode( services, forKey: .services)
        try container.encode( salonID, forKey: .salonID)
        try container.encode( creationDate, forKey: .creationDate)
    }

    enum Keys: String, CodingKey {
        case employeeId      = "_id"
        case name        = "name"
        case services           = "services"
        case salonID      = "salonID"
        case creationDate           = "creationDate"
        
    }
}
