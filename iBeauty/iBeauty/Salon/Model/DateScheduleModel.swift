//
//  DateScheduleModel.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 30/11/20.
//

import Foundation

class DateScheduleModel {
    var day:String?
    var dayMonth:String?
    var date:Date?
    
    init( day:String?, dayMonth:String?, date:Date?) {
        self.day = day
        self.dayMonth = dayMonth
        self.date = date
    }
}
