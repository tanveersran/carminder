//
//  Data.swift
//  CarMinder
//
//  Created by Default User on 3/30/24.
//

import UIKit

class Car: NSObject {
    var id : Int?
    var name : String?
    var vin : String?
    var image: String?
    
    func initWithData(theRow i:Int, theName n:String, theVin v:String, theImage ima:String
                      )
    {
        id = i
        name = n
        vin = v
        image = ima
        
    }
}
