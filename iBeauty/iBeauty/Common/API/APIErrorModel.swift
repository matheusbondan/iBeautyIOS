//
//  APIErrorModel.swift
//  TransactionPod
//
//  Created by Thiago Bertoletti on 20/04/20.
//

import Foundation

public class APIErrorModel: NSObject, Codable {
    
    open var errorCode: String?
    open var message: String?
    open var path: String?
    open var url: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .errorCode)) as String??) { errorCode = value }
        if let value = ((try? values.decode(String?.self, forKey: .message)) as String??) { message = value }
        if let value = ((try? values.decode(String?.self, forKey: .path)) as String??) { path = value }
        if let value = ((try? values.decode(String?.self, forKey: .url)) as String??) { url = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( errorCode, forKey: .errorCode)
        try container.encode( message, forKey: .message)
        try container.encode( path, forKey: .path)
        try container.encode( url, forKey: .url)
    }

    enum Keys: String, CodingKey {
        case errorCode          = "errorCode"
        case message            = "message"
        case path               = "path"
        case url                = "url"
        
    }
}
