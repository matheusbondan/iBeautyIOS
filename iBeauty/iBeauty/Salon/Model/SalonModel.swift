//
//  SalonModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation
import UIKit
import CoreLocation

class SalonModel:NSObject {
    var image:UIImage?
    var name:String?
    var address:String?
    var rate:Double?
    var coordinates:CLLocation?
    
    init(image:UIImage?, name:String?, address:String?, rate:Double?, coordinates:CLLocation?) {
        self.image = image
        self.name = name
        self.address = address
        self.rate = rate
        self.coordinates = coordinates
    }
}
