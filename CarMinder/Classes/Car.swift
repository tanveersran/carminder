//
//  Data.swift
//  CarMinder
//
//  Created by Tanveer on 3/30/24.
// This file is used to create object for Car class and this is main class we are using for our project.

import UIKit

class Car: NSObject {
    var id : Int? // car id is saved in id field
    var name : String? // car name is saved in name field
    var vin : String? // vin number is saved in vin field
    var image: String?  //image of car is saved image field
    
    // initWithData method is used to initialize Car class which have 4 parameters id, name, vin, image
    func initWithData(theRow i:Int, theName n:String, theVin v:String, theImage ima:String
                      )
    {
        // we are assigning the values of parameters to the fields of Car class
        id = i
        name = n
        vin = v
        image = ima
        
    }
}
