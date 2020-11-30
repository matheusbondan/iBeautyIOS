//
//  EmployeeModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation
import UIKit

class EmployeeModel:NSObject {
    var name:String?
    var price:String?
    var image:UIImage?
    
    init( name:String?, price:String?, image:String?) {
        self.price = price
        self.name = name
        self.image = UIImage(named: image ?? "user-placeholder")
    }
}
