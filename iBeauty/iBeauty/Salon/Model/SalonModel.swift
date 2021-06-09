//
//  SalonModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation
import UIKit
import CoreLocation

//class SalonModel:NSObject {
//    var image:UIImage?
//    var name:String?
//    var address:String?
//    var rate:Double?
//    var coordinates:CLLocation?
//
//    init(image:UIImage?, name:String?, address:String?, rate:Double?, coordinates:CLLocation?) {
//        self.image = image
//        self.name = name
//        self.address = address
//        self.rate = rate
//        self.coordinates = coordinates
//    }
//}

public class SalonModel: NSObject, Codable {
    
    open var services: [ServiceModel]?
    open var idSalon: String?
    open var address: AddressModel?
    open var email: String?
    open var ownerName: String?
    open var phone: String?
    open var cnpj: String?
    open var rating: Double?
    open var name: String?
    open var employees: [EmployeeModel]?
    open var ratings: [RateModel]?
    open var startHour: String?
    open var endHour: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode([ServiceModel]?.self, forKey: .services)) as [ServiceModel]?) { services = value }
        
        if let value = ((try? values.decode(String?.self, forKey: .idSalon)) as String??) { idSalon = value }
        if let value = ((try? values.decode(AddressModel?.self, forKey: .address)) as AddressModel??) { address = value }
        if let value = ((try? values.decode(String?.self, forKey: .email)) as String??) { email = value }
       
        if let value = ((try? values.decode(String?.self, forKey: .ownerName)) as String??) { ownerName = value }
        if let value = ((try? values.decode(String?.self, forKey: .phone)) as String??) { phone = value }
        if let value = ((try? values.decode(String?.self, forKey: .cnpj)) as String??) { cnpj = value }
        if let value = ((try? values.decode(Double?.self, forKey: .rating)) as Double??) { rating = value }
        if let value = ((try? values.decode(String?.self, forKey: .name)) as String??) { name = value }
        
        if let value = ((try? values.decode([EmployeeModel]?.self, forKey: .employees)) as [EmployeeModel]??) { employees = value }
        if let value = ((try? values.decode([RateModel]?.self, forKey: .ratings)) as [RateModel]??) { ratings = value }
        
        if let value = ((try? values.decode(String?.self, forKey: .startHour)) as String??) { startHour = value }
        if let value = ((try? values.decode(String?.self, forKey: .endHour)) as String??) { endHour = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( idSalon, forKey: .idSalon)
        try container.encode( address, forKey: .address)
        try container.encode( email, forKey: .email)
        try container.encode( services, forKey: .services)
        try container.encode( ownerName, forKey: .ownerName)
        try container.encode( phone, forKey: .phone)
        try container.encode( rating, forKey: .rating)
        try container.encode( cnpj, forKey: .cnpj)
        try container.encode( name, forKey: .name)
        try container.encode( startHour, forKey: .startHour)
        try container.encode( endHour, forKey: .endHour)
        
        try container.encode( employees, forKey: .employees)
        try container.encode( ratings, forKey: .ratings)
    }

    enum Keys: String, CodingKey {
        case idSalon      = "_id"
        case services        = "services"
        case address           = "address"
        case email           = "email"
        case ownerName      = "ownerName"
        case phone        = "phone"
        case cnpj           = "cnpj"
        case rating           = "rating"
        case name           = "name"
        case startHour           = "startHour"
        case endHour           = "endHour"
        
        case employees           = "employees"
        case ratings           = "ratings"
    }
}
