//
//  APIError.swift
//  TransactionPod
//
//  Created by Thiago Bertoletti on 20/04/20.
//

import Foundation

public class APIError: NSObject, Codable {
    
    open var code: String?
    open var idError: String?
    open var message: String?
    open var errors: [APIErrorModel]?

    
    public override init(){}
    
    public init(type:ErrorTypes) {
        self.code = ""
        self.message = ""
        self.idError = ""
        
        let errorModel = APIErrorModel()

        if type == .reachabilityError{
            errorModel.message = "Sem internet"
        }
        else if type == .defaultError{
            errorModel.message = "Ocorreu um erro"
        }
        else if type == .userNotFound{
            errorModel.message = "Usuário não encontrado"
        }
        
        
        self.errors = [errorModel]
        
        
    }

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .code)) as String??) { code = value }
        if let value = ((try? values.decode(String?.self, forKey: .idError)) as String??) { idError = value }
        if let value = ((try? values.decode(String?.self, forKey: .message)) as String??) { message = value }
        if let value = ((try? values.decode([APIErrorModel]?.self, forKey: .errors)) as [APIErrorModel]??) { errors = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( code, forKey: .code)
        try container.encode( idError, forKey: .idError)
        try container.encode( message, forKey: .message)
        try container.encode( errors, forKey: .errors)
    }

    enum Keys: String, CodingKey {
        case code               = "code"
        case idError            = "id"
        case message            = "message"
        case errors             = "errors"
        
    }
}

public enum ErrorTypes: Int
{
    case reachabilityError = 1
    case defaultError = 2
    case userNotFound = 3
}

