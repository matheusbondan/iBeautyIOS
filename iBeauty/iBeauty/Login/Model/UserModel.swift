//
//  UserModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 17/04/21.
//

import Foundation

public class UserModel: NSObject, Codable {
    
    open var userId: String?
    open var username: String?
    open var email: String?
    open var phone: String?
    open var cpf: String?
    
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .userId)) as String??) { userId = value }
        if let value = ((try? values.decode(String?.self, forKey: .username)) as String??) { username = value }
        if let value = ((try? values.decode(String?.self, forKey: .email)) as String??) { email = value }
        if let value = ((try? values.decode(String?.self, forKey: .phone)) as String??) { phone = value }
        if let value = ((try? values.decode(String?.self, forKey: .cpf)) as String??) { cpf = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( userId, forKey: .userId)
        try container.encode( username, forKey: .username)
        try container.encode( email, forKey: .email)
        try container.encode( phone, forKey: .phone)
        try container.encode( cpf, forKey: .cpf)
    }

    enum Keys: String, CodingKey {
        case userId          = "_id"
        case username        = "username"
        case email           = "email"
        case phone           = "phone"
        case cpf           = "cpf"
    }
}
