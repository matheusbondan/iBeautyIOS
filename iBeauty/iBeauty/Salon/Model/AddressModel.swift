//
//  AddressModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 04/06/21.
//

import Foundation

public class AddressModel: NSObject, Codable {
    
    open var addressID: String?
    open var street: String?
    open var zipcode: String?
    open var number: String?
    open var neighborhood: String?
    open var city: String?
    open var complement: String?
    open var state: String?
    open var country: String?
    open var lat: Double?
    open var lng: Double?
    open var allAddress: String?
    
    public override init(){}

    required public init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: Keys.self)
        if let value = ((try? values.decode(String?.self, forKey: .addressID)) as String??) { addressID = value }
        if let value = ((try? values.decode(String?.self, forKey: .street)) as String??) { street = value }
        if let value = ((try? values.decode(String?.self, forKey: .zipcode)) as String??) { zipcode = value }
        if let value = ((try? values.decode(String?.self, forKey: .number)) as String??) { number = value }
        if let value = ((try? values.decode(String?.self, forKey: .neighborhood)) as String??) { neighborhood = value }
        if let value = ((try? values.decode(String?.self, forKey: .city)) as String??) { city = value }
        if let value = ((try? values.decode(String?.self, forKey: .complement)) as String??) { complement = value }
        if let value = ((try? values.decode(String?.self, forKey: .state)) as String??) { state = value }
        if let value = ((try? values.decode(String?.self, forKey: .country)) as String??) { country = value }
        if let value = ((try? values.decode(Double?.self, forKey: .lat)) as Double??) { lat = value }
        if let value = ((try? values.decode(Double?.self, forKey: .lng)) as Double??) { lng = value }
        if let value = ((try? values.decode(String?.self, forKey: .allAddress)) as String??) { allAddress = value }
    }

    public func encode(to encode: Encoder) throws{
        var container = try encode.container(keyedBy: Keys.self)
        try container.encode( addressID, forKey: .addressID)
        try container.encode( street, forKey: .street)
        try container.encode( zipcode, forKey: .zipcode)
        try container.encode( number, forKey: .number)
        try container.encode( neighborhood, forKey: .neighborhood)
        try container.encode( city, forKey: .city)
        try container.encode( complement, forKey: .complement)
        try container.encode( state, forKey: .state)
        try container.encode( country, forKey: .country)
        try container.encode( lat, forKey: .lat)
        try container.encode( lng, forKey: .lng)
        try container.encode( allAddress, forKey: .allAddress)
    }

    enum Keys: String, CodingKey {
        case addressID      = "_id"
        case street        = "street"
        case zipcode           = "zipcode"
        case number           = "number"
        case neighborhood           = "neighborhood"
        case city           = "city"
        case complement           = "complement"
        case state           = "state"
        case country           = "country"
        case lat           = "lat"
        case lng           = "lng"
        case allAddress           = "addressComplete"
    }
}
