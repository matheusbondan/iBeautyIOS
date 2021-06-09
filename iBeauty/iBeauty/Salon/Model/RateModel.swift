//
//  RateModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 03/06/21.
//

import Foundation

public class RateModel: NSObject, Codable {
    
    open var salon: SalonModel?
    open var user: UserModel?
    open var salonID: String?
    open var rateScore: Int?
    open var comment: String?
    open var reteID: String?
    open var creationDate: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(SalonModel?.self, forKey: .salon)) as SalonModel??) { salon = value }
        if let value = ((try? values.decode(String?.self, forKey: .reteID)) as String??) { reteID = value }
        if let value = ((try? values.decode(UserModel?.self, forKey: .user)) as UserModel??) { user = value }
        if let value = ((try? values.decode(String?.self, forKey: .salonID)) as String??) { salonID = value }
        if let value = ((try? values.decode(String?.self, forKey: .comment)) as String??) { comment = value }
        if let value = ((try? values.decode(Int?.self, forKey: .rateScore)) as Int??) { rateScore = value }
        if let value = ((try? values.decode(String?.self, forKey: .creationDate)) as String??) { creationDate = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( salon, forKey: .salon)
        try container.encode( reteID, forKey: .reteID)
        try container.encode( user, forKey: .user)
        try container.encode( salonID, forKey: .salonID)
        try container.encode( comment, forKey: .comment)
        try container.encode( rateScore, forKey: .rateScore)
        try container.encode( creationDate, forKey: .creationDate)
    }

    enum Keys: String, CodingKey {
        case reteID      = "_id"
        case salon        = "salon"
        case user           = "user"
        case salonID           = "salonID"
        case comment           = "comment"
        case rateScore           = "rateScore"
        case creationDate           = "creationDate"
    }
}
