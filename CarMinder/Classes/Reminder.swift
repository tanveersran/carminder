//
//  Reminder.swift
//  CarMinder
//
//  Created by Default User on 4/13/24.
//

import UIKit

class Reminder: NSObject {
    var id : Int?
    var title : String?
    var dueDate : Date?
    var dueDistance: Int?
    var carId: Int?
    
    func initWithData(theRow i:Int, theTitle n:String, theDueDate v:Date, theDueDistance distance:Int , theCarId ima:Int
                      )
    {
        id = i
        title = n
        dueDate = v
        dueDistance = distance
        carId = ima
        
    }
}
