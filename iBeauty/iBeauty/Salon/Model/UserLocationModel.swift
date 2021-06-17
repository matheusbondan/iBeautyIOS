//
//  UserLocationModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 17/06/21.
//

import Foundation
import CoreLocation

public class UserLocationModel: NSObject, Codable {
    open var addressName: String?
    open var lat: CLLocationDegrees?
    open var lng: CLLocationDegrees?
}
