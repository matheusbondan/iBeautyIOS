//
//  ServiceModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation

open class ServiceModel:NSObject, Codable {
    
    open var name:String?
    open var serviceId: String?
    open var typeService: String?
    open var descriptionService: String?
    open var categoryID: String?
    open var creationDate: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .serviceId)) as String??) { serviceId = value }
        if let value = ((try? values.decode(String?.self, forKey: .name)) as String??) { name = value }
        if let value = ((try? values.decode(String?.self, forKey: .typeService)) as String??) { typeService = value }
        if let value = ((try? values.decode(String?.self, forKey: .descriptionService)) as String??) { descriptionService = value }
        if let value = ((try? values.decode(String?.self, forKey: .categoryID)) as String??) { categoryID = value }
        if let value = ((try? values.decode(String?.self, forKey: .creationDate)) as String??) { creationDate = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( serviceId, forKey: .serviceId)
        try container.encode( name, forKey: .name)
        try container.encode( typeService, forKey: .typeService)
        try container.encode( descriptionService, forKey: .descriptionService)
        try container.encode( categoryID, forKey: .categoryID)
        try container.encode( creationDate, forKey: .creationDate)
    }

    enum Keys: String, CodingKey {
        case serviceId      = "_id"
        case name        = "name"
        case typeService           = "typeService"
        case descriptionService      = "descriptionService"
        case categoryID        = "categoryID"
        case creationDate           = "creationDate"
        
    }
}
