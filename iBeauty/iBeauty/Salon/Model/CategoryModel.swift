//
//  CategoryModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/04/21.
//

import Foundation

public class CategoryModel: NSObject, Codable {
    
    open var categoryId: String?
    open var name: String?
    open var type: String?
    open var services: [ServiceModel]?
    
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .categoryId)) as String??) { categoryId = value }
        if let value = ((try? values.decode(String?.self, forKey: .name)) as String??) { name = value }
        if let value = ((try? values.decode(String?.self, forKey: .type)) as String??) { type = value }
        if let value = ((try? values.decode([ServiceModel]?.self, forKey: .services)) as [ServiceModel]?) { services = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( categoryId, forKey: .categoryId)
        try container.encode( name, forKey: .name)
        try container.encode( type, forKey: .type)
        try container.encode( services, forKey: .services)
    }

    enum Keys: String, CodingKey {
        case categoryId      = "_id"
        case name        = "name"
        case type           = "type"
        case services           = "services"
    }
}
