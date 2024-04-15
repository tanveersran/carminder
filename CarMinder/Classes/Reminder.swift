//
//  Reminder.swift
//  CarMinder
//
//  Created by Aditya on 4/13/24.
//  This file is used to create object for Reminder class, it is used to store the reminder details
//  so that reminders can be shown to user at the time of due date.
//

import UIKit

class Reminder: NSObject {
    var id : Int? // id of the reminder
    var title : String? // title of the reminder
    var dueDate : Date? // due date of the reminder
    var dueDistance: Int?   // due distance of the reminder
    var carId: Int? // car id of the reminder
    
    // init function is used to initialize the class of Reminder
    func initWithData(theRow i:Int, theTitle n:String, theDueDate v:Date, theDueDistance distance:Int , theCarId ima:Int
                      )
    {
        id = i  // setting id of the reminder
        title = n   // setting title of the reminder
        dueDate = v // setting due date of the reminder
        dueDistance = distance  // setting due distance of the reminder
        carId = ima // setting car id of the reminder
        
    }
}
