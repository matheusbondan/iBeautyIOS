//
//  ServiceModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation

class ServiceModel:NSObject {
    var name:String?
    var price:String?
    var time:String?
    
    init( name:String?, price:String?, time:String?) {
        self.price = price
        self.name = name
        self.time = time
    }
}
